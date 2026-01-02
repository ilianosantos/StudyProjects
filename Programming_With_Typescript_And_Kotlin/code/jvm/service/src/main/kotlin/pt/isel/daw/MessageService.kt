package pt.isel.daw

import jakarta.annotation.PreDestroy
import jakarta.inject.Named
import org.slf4j.LoggerFactory
import java.io.IOException
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.withLock

sealed class MessageError {
    data object MessageChannelNotFound : MessageError()
    data object InvalidMessageSender : MessageError()
    data object DoesNotBelongToChannel : MessageError()
    data object InvalidInputMessage : MessageError()
    data object NoPermission : MessageError()
}

const val DELAY = 2L
const val PERIOD = 2L

@Named
class MessageService(
    private val trxManager: TransactionManager
) {
    private val listeners = mutableMapOf<Int, List<UpdatedChannelEmitter>>()
    private val lock = ReentrantLock()
    private val executor =
        Executors
            .newScheduledThreadPool(1)
            .also {
                it.scheduleAtFixedRate({ keepAlive() }, DELAY, PERIOD, TimeUnit.SECONDS)
            }

    // Shutdown the executor service when the application is stopped
    @PreDestroy
    fun destroy() {
        executor.shutdown()
    }

    private fun keepAlive() =
        lock.withLock {
//            logger.info("keepAlive, sending to {} listeners", listeners.values.flatten().size)
            val signal = NewMessageEmitter.KeepAlive
            listeners.values.flatten().forEach {
                try {
                    it.emit(signal)
                } catch (ex: Exception) {
                    logger.info("Exception while sending keepAlive signal - {}", ex.message)
                }
            }
        }

    fun removeListener(userId: Int, channelId: Int): Boolean {
        val ch = trxManager.run {
            repoChannels.findById(channelId)
        }
        requireNotNull(ch)
        val listener = listeners[channelId]?.firstOrNull { it.userId == userId }
        if (listener == null) return false
        removeEmitter(channelId, listener)
        return true
    }

    private fun removeEmitter(
        channelId: Int,
        listener: UpdatedChannelEmitter
    ) = lock.withLock {
        logger.info("removing listener")
        val oldListeners = listeners[channelId]
        requireNotNull(oldListeners)
        listeners[channelId] = oldListeners - listener
    }

    fun addEmitter(
        channelId: Int,
        listener: UpdatedChannelEmitter,
    ) = lock.withLock {
        val ch = trxManager.run {
            repoChannels.findById(channelId)
        }
        requireNotNull(ch)
        val oldListeners = listeners.getOrDefault(channelId, emptyList())
        listeners[channelId] = oldListeners + listener
        listener.onCompletion {
            logger.info("onCompletion")
            removeEmitter(channelId, listener)
        }
        listener.onError {
            logger.info("onError")
            removeEmitter(channelId, listener)
        }
        listener
    }

    private fun sendMessageToAll(
        channelId: Int,
        signal: NewMessageEmitter
    ) {
        listeners[channelId]?.forEach {
            try {
                it.emit(signal)
            } catch (ex: IOException) {
                logger.error("IOException while sending Message signal - {}", ex.message)
            } catch (ex: Exception) {
                logger.info("Exception while sending Message signal - {}", ex.message)
            }
        }
    }

    companion object {
        private val logger = LoggerFactory.getLogger(ChannelService::class.java)
    }

    /**
     * Sends a message to a channel
     * @return true if the message was sent or an error: MessageChannelNotFound, InvalidMessageSender, DoesNotBelongToChannel, NoPermission, InvalidInputMessage
     */
    fun sendMessage(senderId: Int, channelId: Int, message: String): Either<MessageError, Boolean> = trxManager.run {
        repoChannels.findById(channelId) ?: return@run failure(MessageError.MessageChannelNotFound)
        repoUsers.findById(senderId) ?: return@run failure(MessageError.InvalidMessageSender)
        val participant = repoParticipants
            .findAll()
            .firstOrNull { it.channel.id == channelId && it.user.id == senderId }
                ?: return@run failure(MessageError.DoesNotBelongToChannel)
        if (participant.type == ParticipantKind.READER_ONLY)
            return@run failure(MessageError.NoPermission)
        if (message.isBlank()) return@run failure(MessageError.InvalidInputMessage)
        val msg = repoMessages.createMessage(message, participant)
        sendMessageToAll(
            participant.channel.id,
            NewMessageEmitter.Text(msg.id, msg)
        )
        success(true)
    }

    /**
     * Gets messages from a channel with the given id
     * @param userId the user id
     * @param channelId the channel id
     * @param skip the number of messages to skip
     * @param max the maximum number of messages to get
     * @return the messages or an error: MessageChannelNotFound
     */
    fun getMessages(userId: Int, channelId: Int, skip: Int, max: Int): Either<MessageError, List<Message>> = trxManager.run {
        val channel = repoChannels.findById(channelId)?: return@run failure(MessageError.MessageChannelNotFound)
        if (repoParticipants.findAllByUserId(userId).none { it.channel.id == channelId })
            return@run failure(MessageError.DoesNotBelongToChannel)
        success(repoMessages.findByChannel(channel.id, skip, max))
    }
}
