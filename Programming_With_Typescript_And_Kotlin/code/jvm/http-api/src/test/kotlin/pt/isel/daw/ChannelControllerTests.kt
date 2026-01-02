package pt.isel.daw

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.controllers.ChannelController
import pt.isel.daw.mem.*
import pt.isel.daw.model.input.*
import pt.isel.daw.model.output.OutputChannel

class ChannelControllerTests {
    private val transactionManager = TransactionManagerInMem()
    private val channelService = ChannelService(transactionManager)
    private val messageService = MessageService(transactionManager)
    private val channelController = ChannelController(channelService, messageService)
    private val channels = transactionManager.repoChannels.channels
    private val messages = transactionManager.repoMessages.messages
    private val participants = transactionManager.repoParticipants.participants
    private val registrationInvites = transactionManager.repoUsers.registrationInvites
    private val users = transactionManager.repoUsers.users

    @BeforeEach
    fun setUp() {
        messages.clear()
        participants.clear()
        users.clear()
        channels.clear()
        users.add(User(0, "user1", "email@email.com", PasswordValidationInfo("password")))
        users.add(User(1, "user2", "email@email.com", PasswordValidationInfo("password")))
        channels.add(Channel(0, "channel1", users[0], ChannelKind.PUBLIC, null, null))
        channels.add(Channel(1, "channel2", users[1], ChannelKind.PRIVATE, "code", "code"))
        users.add(User(0, "user1", "email@email.com", PasswordValidationInfo("password")))
        users.add(User(1, "user2", "email2@email.com", PasswordValidationInfo("password")))
        users.add(User(2, "user3", "email3@email.com", PasswordValidationInfo("password")))
        users.add(User(3, "user4", "email4@email.com", PasswordValidationInfo("password")))
        participants.add(Participant(0, users[0], channels[0], ParticipantKind.WRITER))
        participants.add(Participant(1, users[1], channels[1], ParticipantKind.WRITER))
        participants.add(Participant(2, users[2], channels[1], ParticipantKind.READER_ONLY))
        messages.add(Message(0, "message1", participants[0]))
        messages.add(Message(1, "message2", participants[1]))
    }

    @Test
    fun `test get all public channels`() {
        val result = channelController.getAllPublicChannels()

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertTrue(result.body is List<*>) { "Expected a list of channels but got ${result.body}" }
    }

    @Test
    fun `test get all user channels`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getAllUserChannels(authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertTrue(result.body is List<*>) { "Expected a list of channels but got ${result.body}" }
    }

    @Test
    fun `get channel by id returns channel`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getChannelById(channels[0].id, authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertTrue(result.body is OutputChannel) { "Expected a channel but got ${result.body}" }
    }

    @Test
    fun `get channel by id returns not found`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getChannelById(100, authUser)

        assertEquals(404, result.statusCode.value()) {
            "Expected status code to be 404 Not Found but got ${result.statusCode}"
        }
    }

    @Test
    fun `test create channel public channel`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputChannel = InputChannel(name = "newestChannel", type = "public")
        val result = channelController.createChannel(inputChannel, authUser)

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test create channel private channel`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputChannel = InputChannel(name = "newestChannel", type = "private")
        val result = channelController.createChannel(inputChannel, authUser)

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test create channel with invalid input`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")

        // Empty
        val inputChannel1 = InputChannel(name = "", type = "")
        val result1 = channelController.createChannel(inputChannel1, authUser)

        assertEquals(400, result1.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result1.statusCode}"
        }

        // Null
        val inputChannel2 = InputChannel(name = null, type = null)
        val result2 = channelController.createChannel(inputChannel2, authUser)

        assertEquals(400, result2.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result2.statusCode}"
        }

        // Invalid type
        val inputChannel3 = InputChannel(name = "Name", type = "invalid")
        val result3 = channelController.createChannel(inputChannel3, authUser)

        assertEquals(400, result3.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result3.statusCode}"
        }
    }

    @Test
    fun `test join public channel returns OK`() {
        val user = users[1]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputPublicJoin = InputPublicChannelJoin(0)
        val result = channelController.joinPublicChannel(inputPublicJoin, authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected ok status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test join public channel returns not found`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputPublicJoin = InputPublicChannelJoin(999)
        val result = channelController.joinPublicChannel(inputPublicJoin, authUser)

        assertEquals(404, result.statusCode.value()) {
            "Expected status code to be 404 Not Found but got ${result.statusCode}"
        }
    }

    @Test
    fun `test join private channel returns OK`() {
        val user = User(3, "user4", "email4@email.com", PasswordValidationInfo("password"))
        val authUser = AuthenticatedUser(user, "validToken")
        val inputPrivateJoin = InputPrivateChannelJoin("code")
        val result = channelController.joinPrivateChannel(inputPrivateJoin, authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected ok status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test join private channel returns not found`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputPrivateJoin = InputPrivateChannelJoin("invalidCode")
        val result = channelController.joinPrivateChannel(inputPrivateJoin, authUser)

        assertEquals(404, result.statusCode.value()) {
            "Expected status code to be 404 Not Found but got ${result.statusCode}"
        }
    }

    @Test
    fun `test join private channel returns already member`() {
        val user = users[1]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputPrivateJoin = InputPrivateChannelJoin("code")
        val result = channelController.joinPrivateChannel(inputPrivateJoin, authUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
    }

    @Test
    fun `test leave channel returns OK`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.leaveChannel(InputChannelLeave(channels[0].id), authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected ok status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test leave channel returns bad request`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.leaveChannel(InputChannelLeave(999), authUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
    }

    @Test
    fun `test get messages from channel returns messages`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getMessages(channels[0].id,0,999, authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertTrue(result.body is List<*>) { "Expected a list of messages but got ${result.body}" }
    }

    @Test
    fun `test get messages from channel returns not found`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getMessages(9990,0,999, authUser)

        assertEquals(404, result.statusCode.value()) {
            "Expected status code to be 404 Not Found but got ${result.statusCode}"
        }
    }

    @Test
    fun `test get messages returns does not belong to channel`() {
        val user = users[1]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.getMessages(channels[0].id,0, 999, authUser)

        assertEquals(401, result.statusCode.value()) {
            "Expected status code to be 401 Unauthorized but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("DoesNotBelongToChannel", result.body?.toString() ?: "") {
                "Expected 'DoesNotBelongToChannel' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test send message to a channel returns status OK`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputMessage = InputMessage("message")
        val result = channelController.sendMessage(channels[0].id, inputMessage, authUser)

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
    }

    @Test
    fun `test send message returns invalid input message`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputMessage = InputMessage("")
        val result = channelController.sendMessage(channels[0].id, inputMessage, authUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("InvalidInputMessage", result.body?.toString() ?: "") {
                "Expected 'InvalidInputMessage' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test send message returns channel not found`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")
        val inputMessage = InputMessage("message")
        val result = channelController.sendMessage(999, inputMessage, authUser)

        assertEquals(404, result.statusCode.value()) {
            "Expected status code to be 404 Not Found but got ${result.statusCode}"
        }
    }

    @Test
    fun `test send message returns does not belong to channel`() {
        val user = users[1]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController
            .sendMessage(channels[0].id, InputMessage("message"), authUser)

        assertEquals(401, result.statusCode.value()) {
            "Expected status code to be 401 Unauthorized but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("DoesNotBelongToChannel", result.body?.toString() ?: "") {
                "Expected 'DoesNotBelongToChannel' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test send message returns no permission`() {
        val user = users[2]
        val authUser = AuthenticatedUser(user, "validToken")
        val result = channelController.sendMessage(channels[1].id, InputMessage("message"), authUser)

        assertEquals(401, result.statusCode.value()) {
            "Expected status code to be 401 Unauthorized but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("NoPermission", result.body?.toString() ?: "") {
                "Expected 'NoPermission' but got ${result.body}"
            }
        }
    }
}
