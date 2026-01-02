package pt.isel.daw

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.*

class MessageServiceTests {
    private val trxManager = TransactionManagerInMem()
    private val messageService = MessageService(trxManager)
    private val channels = trxManager.repoChannels.channels
    private val messages = trxManager.repoMessages.messages
    private val participants = trxManager.repoParticipants.participants
    private val users = trxManager.repoUsers.users

    @BeforeEach
    fun setUp() {
        messages.clear()
        participants.clear()
        users.clear()
        channels.clear()
        val pass = PasswordValidationInfo("password")
        val user0 = User(0, "user0", "user0@example.com", pass)
        val user1 = User(1, "user1", "user1@example.com", pass)
        channels.add(Channel(0, "channel1", user0, ChannelKind.PUBLIC, null, null))
        channels.add(Channel(1, "channel2", user1, ChannelKind.PRIVATE, "code", "code"))
        users.add(user0)
        users.add(user1)
        participants.add(Participant(0, user0, channels[0], ParticipantKind.READER_ONLY))
        participants.add(Participant(1, user1, channels[1], ParticipantKind.WRITER))
        messages.add(Message(0, "message1", participants[0]))
        messages.add(Message(1, "message2", participants[1]))
    }

    @Test
    fun `test send message sends a message`() {
        val senderId = 1
        val channelId = 1
        val message = "Inserted message"

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Success && result.value) { "Expected success(true) but got $result" }
        assert(messages.last().text == message) { "Expected message to be $message but got ${messages.last().text}" }
    }

    @Test
    fun `test send message fails when channel does not exist`() {
        val senderId = 1
        val channelId = 2
        val message = "Inserted message"

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Failure && result.value == MessageError.MessageChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test send message fails when sender is not in channel`() {
        val senderId = 999999
        val channelId = 1
        val message = "Inserted message"

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Failure && result.value == MessageError.InvalidMessageSender) {
            "Expected invalid sender but got $result"
        }
    }

    @Test
    fun `test send message fails when user does not belong to channel`() {
        val senderId = 0
        val channelId = 1
        val message = "Inserted message"

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Failure && result.value == MessageError.DoesNotBelongToChannel) {
            "Expected does not belong to channel but got $result"
        }
    }

    @Test
    fun `test send message fails when message is blank`() {
        val senderId = 1
        val channelId = 1
        val message = ""

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Failure && result.value == MessageError.InvalidInputMessage) {
            "Expected invalid input message but got $result"
        }
    }

    @Test
    fun `test send message fails when user has no permission`() {
        val senderId = 0
        val channelId = 0
        val message = "New message"

        val result = messageService.sendMessage(senderId, channelId, message)

        assert(result is Failure && result.value == MessageError.NoPermission) {
            "Expected no permission but got $result"
        }
    }

    @Test
    fun `test get messages returns all messages from a channel`() {
        val userId = 0
        val channelId = 0
        val skip = 0
        val max = 999

        val result = messageService.getMessages(userId, channelId, skip, max)

        assert(result is Success && result.value.size == 1) {
            if (result is Success) "Expected 1 message but got ${result.value.size}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get messages fails when channel does not exist`() {
        val userId = 0
        val channelId = 2
        val skip = 0
        val max = 999

        val result = messageService.getMessages(userId, channelId, skip, max)

        assert(result is Failure && result.value == MessageError.MessageChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }
}
