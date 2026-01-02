package pt.isel.daw

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.*

class ChannelServiceTests {
    private val trxManager = TransactionManagerInMem()
    private val channelService = ChannelService(trxManager)
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
        channels.add(Channel(0, "channel1", user0, ChannelKind.PUBLIC, null , null))
        channels.add(Channel(1, "channel2", user1, ChannelKind.PRIVATE, "inviteCode", "inviteCodeReadOnly"))
        users.add(User(0, "user1", "email@email.com", PasswordValidationInfo("password")))
        users.add(User(1, "user2", "email2@email.com", PasswordValidationInfo("password")))
        participants.add(Participant(0, users[0], channels[0], ParticipantKind.WRITER))
        participants.add(Participant(1, users[1], channels[1], ParticipantKind.WRITER))
        messages.add(Message(0, "message1", participants[0]))
        messages.add(Message(1, "message2", participants[1]))
    }

    @Test
    fun `test get channel by name returns channel`() {
        val channelName = "channel1"

        val result = channelService.getChannelByName(channelName)

        assertTrue(result is Success && result.value.name == channelName) {
            if (result is Success)"Expected channel name to be $channelName but got ${result.value.name}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get channel by name returns not found`() {
        val channelName = "channel999999"

        val result = channelService.getChannelByName(channelName)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test get channel by id returns channel`() {
        val channelId = 0

        val result = channelService.getChannelById(channelId)

        assertTrue(result is Success && result.value.id == channelId) {
            if (result is Success)"Expected channel id to be $channelId but got ${result.value.id}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get channel by id returns not found`() {
        val channelId = 999999

        val result = channelService.getChannelById(channelId)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test get channel by user and channel id returns channel`() {
        val userId = 0
        val channelId = 0

        val result = channelService.getChannelByUserAndChannelId(userId, channelId)

        assertTrue(result is Success && result.value.id == channelId) {
            if (result is Success)"Expected channel id to be $channelId but got ${result.value.id}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get channel by user and channel id returns not found`() {
        val userId = 999999
        val channelId = 0

        val result = channelService.getChannelByUserAndChannelId(userId, channelId)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test get all public channels returns channels`() {
        val result = channelService.getAllPublicChannels()

        assertTrue(result is Success && result.value.size == channels.filter { it.type == ChannelKind.PUBLIC }.size) {
            if (result is Success)"Expected channels size to be 1 but got ${result.value.size}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get participants returns participants`() {
        val channelId = 0

        val result = channelService.getParticipants(channelId)

        assertTrue(result is Success && result.value.size == 1) {
            if (result is Success)"Expected participants size to be 1 but got ${result.value.size}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get participants returns not found`() {
        val channelId = 999999

        val result = channelService.getParticipants(channelId)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test get all channels by user id returns channels`() {
        val userId = 0

        val result = channelService.getAllChannelsByUserId(userId)

        assertTrue(result.size == channels.filter { it.owner.id == userId }.size) {
            "Expected channels size to be 1 but got ${result.size}"
        }
    }

    @Test
    fun `test create channel returns channel`() {
        val name = "channel3"
        val userId = 0
        val type = ChannelKind.PUBLIC

        val result = channelService.createChannel(name, userId, type)

        assertTrue(result is Success && result.value.name == name) {
            if (result is Success)"Expected channel name to be $name but got ${result.value.name}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test create channel returns invalid owner`() {
        val name = "channel3"
        val userId = 999999
        val type = ChannelKind.PUBLIC

        val result = channelService.createChannel(name, userId, type)

        assertTrue(result is Failure && result.value == ChannelError.InvalidChannelOwner) {
            "Expected invalid owner but got $result"
        }
    }

    @Test
    fun `test delete channel returns true`() {
        val channelName = "channel1"

        val result = channelService.deleteChannel(channelName)

        assertTrue(result is Success && result.value) {
            if (result is Success)"Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test delete channel returns not found`() {
        val channelName = "channel999999"

        val result = channelService.deleteChannel(channelName)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test add user to public channel returns true`() {
        val userId = 1
        val channelId = 0

        val result = channelService.addUserToPublicChannel(userId, channelId)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }

        assertTrue(participants.any { it.user.id == userId && it.channel.id == channelId }) {
            "Expected user to be added to channel"
        }
    }

    @Test
    fun `test add user to public channel returns channel not found`() {
        val userId = 0
        val channelId = 999999

        val result = channelService.addUserToPublicChannel(userId, channelId)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test add user to public channel returns invalid member`() {
        val userId = 999999
        val channelId = 0

        val result = channelService.addUserToPublicChannel(userId, channelId)

        assertTrue(result is Failure && result.value == ChannelError.InvalidMember) {
            "Expected invalid member but got $result"
        }
    }

    @Test
    fun `test add user to public channel returns already member`() {
        val userId = 0
        val channelId = 0

        val result = channelService.addUserToPublicChannel(userId, channelId)

        assertTrue(result is Failure && result.value == ChannelError.AlreadyMember) {
            "Expected already member but got $result"
        }
    }

    @Test
    fun `test add user to private channel adds as writer`() {
        val userId = 0
        val code = "inviteCode"

        val result = channelService.addUserToPrivateChannel(userId, code)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }

        assertTrue(participants.any { it.user.id == userId && it.channel.inviteCodeWithWrite == code && it.type == ParticipantKind.WRITER }) {
            "Expected user to be added as writer"
        }
    }

    @Test
    fun `test add user to private channel adds as reader`() {
        val userId = 0
        val code = "inviteCodeReadOnly"

        val result = channelService.addUserToPrivateChannel(userId, code)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }

        assertTrue(participants.any { it.user.id == userId && it.channel.inviteCodeReadOnly == code && it.type == ParticipantKind.READER_ONLY }) {
            "Expected user to be added as reader"
        }
    }

    @Test
    fun `test add user to private channel returns invalid members`() {
        val userId = 999
        val code = "inviteCode"

        val result = channelService.addUserToPrivateChannel(userId, code)

        assertTrue(result is Failure && result.value == ChannelError.InvalidMember) {
            "Expected invalid member but got $result"
        }
    }

    @Test
    fun `test add user to private channel returns channel not found`() {
        val userId = 0
        val code = "invalid"

        val result = channelService.addUserToPrivateChannel(userId, code)

        assertTrue(result is Failure && result.value == ChannelError.ChannelNotFound) {
            "Expected channel not found but got $result"
        }
    }

    @Test
    fun `test add user to private channel returns already member`() {
        val userId = 1
        val code = "inviteCodeReadOnly"

        val result = channelService.addUserToPrivateChannel(userId, code)

        assertTrue(result is Failure && result.value == ChannelError.AlreadyMember) {
            "Expected already member but got $result"
        }
    }

    @Test
    fun `test remove user from channel returns true`() {
        val channelId = 0
        val userId = 0

        val result = channelService.removeUserFromChannel(channelId, userId)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }

        assertTrue(participants.none { it.user.id == userId && it.channel.id == channelId }) {
            "Expected user to be removed from channel"
        }
    }

    @Test
    fun `test remove user from channel returns invalid members`() {
        val channelId = 0
        val userId = 999999

        val result = channelService.removeUserFromChannel(channelId, userId)

        assertTrue(result is Failure && result.value == ChannelError.InvalidChannelMembers) {
            "Expected invalid members but got $result"
        }
    }
}
