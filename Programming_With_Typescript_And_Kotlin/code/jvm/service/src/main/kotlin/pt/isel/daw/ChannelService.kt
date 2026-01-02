package pt.isel.daw

import jakarta.inject.Named
import pt.isel.daw.Channel.Companion.generateInviteCode

sealed class ChannelError {
    data object ChannelNotFound : ChannelError()
    data object InvalidChannelOwner : ChannelError()
    data object InvalidChannelMembers : ChannelError()
    data object InvalidMember : ChannelError()
    data object AlreadyMember : ChannelError()
}

@Named
class ChannelService(
    private val trxManager: TransactionManager
) {
    /**
     * Gets the channel with the given name
     * @return the channel or an error: ChannelNotFound
     */
    fun getChannelByName(channelName: String): Either<ChannelError, Channel> = trxManager.run {
        repoChannels
            .findByName(channelName)
            ?.let { success(it) }
            ?: failure(ChannelError.ChannelNotFound)
    }

    /**
     * Gets the channel with the given id
     * @return the channel or an error: ChannelNotFound
     */
    fun getChannelById(channelId: Int): Either<ChannelError, Channel> = trxManager.run {
        repoChannels
            .findById(channelId)
            ?.let { success(it) }
            ?: failure(ChannelError.ChannelNotFound)
    }

    /**
     * Gets the channel with the given user and channel id
     * @return the channel or an error: ChannelNotFound
     */
    fun getChannelByUserAndChannelId(userId: Int, channelId: Int): Either<ChannelError, Channel> = trxManager.run {
        repoParticipants.findAllByUserId(userId).map { it.channel }
            .find { it.id == channelId }
            ?.let { success(it) }
            ?: failure(ChannelError.ChannelNotFound)
    }

    /**
     * Gets all public channels
     * @return all public channels
     */
    fun getAllPublicChannels(): Either<ChannelError, List<Channel>> = trxManager.run {
        success(repoChannels.findAllPublic())
    }

    /**
     * Get all participants from a channel
     * @return the participants or an error: ChannelNotFound
     */
    fun getParticipants(channelId: Int): Either<ChannelError, List<Participant>> = trxManager.run {
        val channel = repoChannels.findById(channelId) ?: return@run failure(ChannelError.ChannelNotFound)
        success(repoParticipants.findAllByChannel(channel.id))
    }

    /**
     * Get all channels from a user
     */
    fun getAllChannelsByUserId(userId: Int): List<Channel> = trxManager.run {
        repoParticipants.findAllByUserId(userId).map { it.channel }
    }

    /**
     * Creates a new channel with the given fields
     * @return the created channel or an error: InvalidChannelOwner
     */
    fun createChannel(name: String, userId: Int, type: ChannelKind): Either<ChannelError, Channel> = trxManager.run {
        val user = repoUsers.findById(userId) ?: return@run failure(ChannelError.InvalidChannelOwner)
        val readCode = getCode(type)
        val writeCode = getCode(type)
        val channel = repoChannels.createChannel(name, user, type, readCode, writeCode)
        repoParticipants.createParticipant(user, channel, ParticipantKind.OWNER)
        success(channel)
    }
    private fun getCode(type: ChannelKind) = if (type == ChannelKind.PUBLIC) null else generateInviteCode()

    /**
     * Deletes the channel with the given name
     * @return true if the channel was deleted or an error: ChannelNotFound
     */
    fun deleteChannel(channelName: String): Either<ChannelError, Boolean> = trxManager.run {
        repoChannels
            .findByName(channelName)
            ?.let { success(repoChannels
                .also { ch->ch.deleteById(it.id)}
                .findByName(channelName) == null
            )} ?: return@run failure(ChannelError.ChannelNotFound)
    }

    /**
     * Adds a user to a public channel
     * @return the participant or an error: ChannelNotFound, InvalidMember, AlreadyMember
     */
    fun addUserToPublicChannel(userId: Int, channelId: Int): Either<ChannelError, Boolean> = trxManager.run {
        val user = repoUsers.findById(userId) ?: return@run failure(ChannelError.InvalidMember)
        val channel = repoChannels.findById(channelId) ?: return@run failure(ChannelError.ChannelNotFound)
        if (repoParticipants.findByChannelAndId(channel.id, user.id) != null) return@run failure(ChannelError.AlreadyMember)
        repoParticipants.createParticipant(user, channel, ParticipantKind.WRITER)
        success(true)
    }

    /**
     * Adds a user to a private channel
     * @return the participant or an error: ChannelNotFound, InvalidMember, AlreadyMember
     */
    fun addUserToPrivateChannel(userId: Int, inviteCode: String): Either<ChannelError, Boolean> = trxManager.run {
        val user = repoUsers.findById(userId) ?: return@run failure(ChannelError.InvalidMember)
        val channel = repoChannels.findByInvite(inviteCode) ?: return@run failure(ChannelError.ChannelNotFound)
        if (repoParticipants.findByChannelAndId(channel.id, userId) != null) return@run failure(ChannelError.AlreadyMember)
        when (inviteCode) {
            channel.inviteCodeReadOnly -> repoParticipants.createParticipant(user, channel, ParticipantKind.READER_ONLY)
            channel.inviteCodeWithWrite -> repoParticipants.createParticipant(user, channel, ParticipantKind.WRITER)
            else -> throw IllegalStateException("Invalid invite code")
        }
        success(true)
    }
    /**
     * Removes a user from a channel
     * @return true if the user was removed or an error: InvalidChannelMembers
     */
    fun removeUserFromChannel(channelId: Int, userId: Int): Either<ChannelError, Boolean> = trxManager.run {
        repoParticipants.findByChannelAndId(channelId, userId) ?: return@run failure(ChannelError.InvalidChannelMembers)
        repoParticipants.deleteByChannelAndId(channelId, userId)
        success(true)
    }
}
