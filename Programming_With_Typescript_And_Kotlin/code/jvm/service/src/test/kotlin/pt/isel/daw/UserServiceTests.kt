package pt.isel.daw

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.*

class UserServiceTests {
    private val trxManager = TransactionManagerInMem()
    private val userService = UserService(trxManager)
    private val channels = trxManager.repoChannels.channels
    private val messages = trxManager.repoMessages.messages
    private val participants = trxManager.repoParticipants.participants
    private val registrationInvites = trxManager.repoUsers.registrationInvites
    private val users = trxManager.repoUsers.users
    private val tokens = trxManager.repoUsers.tokens

    @BeforeEach
    fun setUp() {
        registrationInvites.clear()
        messages.clear()
        participants.clear()
        tokens.clear()
        users.clear()
        channels.clear()
        val pass = PasswordValidationInfo("password")
        val user0 = User(0, "user0", "user0@example.com", pass)
        val user1 = User(1, "user1", "user1@example.com", pass)
        channels.add(Channel.createChannel(0, "channel1", user0, ChannelKind.PUBLIC, null, null))
        channels.add(Channel.createChannel(1, "channel2", user1, ChannelKind.PRIVATE, "read", "write"))
        users.add(User(0, "user1", "email@email.com", PasswordValidationInfo("password")))
        users.add(User(1, "user2", "email2@email.com", PasswordValidationInfo("password")))
        tokens.add(Token(TokenValidationInfo("token"), 1, 0, users[0]))
        tokens.add(Token(TokenValidationInfo("token2"), 0, 0, users[0]))
        tokens.add(Token(TokenValidationInfo("token3"), 0, 0, users[1]))
        participants.add(Participant(0, users[0], channels[0], ParticipantKind.WRITER))
        participants.add(Participant(1, users[1], channels[1], ParticipantKind.WRITER))
        messages.add(Message(0, "message1", participants[0]))
        messages.add(Message(1, "message2", participants[1]))
        registrationInvites.add(RegistrationInvite("code"))
    }

    @Test
    fun `test login returns token`() {
        val name = "user1"
        val password = "password"
        users.clear()
        users.add(User(0, "user1", "email@email.com", PasswordValidationInfo(HashEncoder.hash("password"))))

        val result = userService.login(name, password)

        assertTrue(result is Success) {
            if (result is Success) "Expected token to be 'token' but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test login returns invalid credentials`() {
        val name = "user999999"
        val password = "password"

        val result = userService.login(name, password)

        assertTrue(result is Failure && result.value == UserError.InvalidCredentials) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test check user tokens`() {
        val user = users[0]
        val maxTokens = 1
        val time = System.currentTimeMillis()
        val token1 = Token(TokenValidationInfo("newToken1"), time + 1, time, user)
        val token2 = Token(TokenValidationInfo("newToken2"), time, time, user)
        tokens.add(token1)
        tokens.add(token2)

        userService.checkUserTokens(user, maxTokens)

        val expected = tokens.size - tokens.filter { it.user == users[0] }.size + maxTokens
        assertTrue(tokens.size == expected) {
            "Expected tokens size to be $expected but got ${tokens.size}"
        }

        println(tokens)
        assertTrue(tokens.contains(token1)) {
            "Expected tokens to contain the most recent token (newToken1) but got $tokens"
        }
    }

    @Test
    fun `test logout returns true`() {
        val token = Token(TokenValidationInfo("token"), 0, 0, users[0])
        tokens.add(token)

        val result = userService.logout(token.token)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test logout returns not logged in`() {
        val valInfo = TokenValidationInfo("token999999")

        val result = userService.logout(valInfo)

        assertTrue(result is Failure && result.value == UserError.NotLoggedIn) {
            "Expected not logged in but got $result"
        }
    }

    @Test
    fun `test get user by id returns user`() {
        val userId = 0

        val result = userService.getUserById(userId)

        assertTrue(result is Success && result.value.id == userId) {
            if (result is Success) "Expected user id to be $userId but got ${result.value.id}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get user by id returns not found`() {
        val userId = 999999

        val result = userService.getUserById(userId)

        assertTrue(result is Failure && result.value == UserError.UserNotFound) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test get user by email returns user`() {
        val email = "email@email.com"

        val result = userService.getUserByEmail(email)

        assertTrue(result is Success && result.value.email == email) {
            if (result is Success) "Expected user email to be $email but got ${result.value.email}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get user by email returns not found`() {
        val email = "email999999"

        val result = userService.getUserByEmail(email)

        assertTrue(result is Failure && result.value == UserError.UserNotFound) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test create user returns user`() {
        val name = "user999999"
        val email = "email999999@email.com"
        val password = "Password123!"

        val result = userService.createUser(name, email, password)

        assertTrue(result is Success && result.value.email == email) {
            if (result is Success) "Expected user email to be $email but got ${result.value.email}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test create user returns user already exists`() {
        val name = "user1"
        val email = "email999999@email.com"
        val password = "Password123!"

        val result = userService.createUser(name, email, password)

        assertTrue(result is Failure && result.value == UserError.UserAlreadyExists) {
            "Expected user already exists but got $result"
        }
    }

    @Test
    fun `test create user returns password too weak`() {
        val name = "user999999"
        val email = "email999999"
        val password = "password"

        val result = userService.createUser(name, email, password)

        assertTrue(result is Failure && result.value == UserError.PasswordTooWeak) {
            "Expected password too weak but got $result"
        }
    }

    @Test
    fun `test create user returns invalid email`() {
        val name = "user999999"
        val email = "email"
        val password = "Password123!"

        val result = userService.createUser(name, email, password)

        assertTrue(result is Failure && result.value == UserError.InvalidEmail) {
            "Expected invalid email but got $result"
        }
    }

    @Test
    fun `test create user returns email already in use`() {
        val name = "user999999"
        val email = "email@email.com"
        val password = "Password123!"

        val result = userService.createUser(name, email, password)

        assertTrue(result is Failure && result.value == UserError.EmailAlreadyInUse) {
            "Expected email already in use but got $result"
        }
    }

    @Test
    fun `test create user returns need not null parameters`() {
        val name = ""
        val email = ""
        val password = ""

        val result = userService.createUser(name, email, password)

        assertTrue(result is Failure && result.value == UserError.NeedNotNullParameters) {
            "Expected need not null parameters but got $result"
        }
    }

    @Test
    fun `test update user returns true`() {
        val userId = 0
        val newName = "user999999"
        val newEmail = "email999999"
        val newPassword = "password999999"

        val result = userService.updateUser(userId, newName, newEmail, newPassword)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test update user returns user not found`() {
        val userId = 999999
        val newName = "user999999"
        val newEmail = "email999999"
        val newPassword = "password999999"

        val result = userService.updateUser(userId, newName, newEmail, newPassword)

        assertTrue(result is Failure && result.value == UserError.UserNotFound) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test update user returns need not null parameters`() {
        val userId = 0

        val result = userService.updateUser(userId)

        assertTrue(result is Failure && result.value == UserError.NeedNotNullParameters) {
            "Expected need not null parameters but got $result"
        }
    }

    @Test
    fun `test delete user returns true`() {
        val userId = 0

        val result = userService.deleteUser(userId)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test delete user returns user not found`() {
        val userId = 999999

        val result = userService.deleteUser(userId)

        assertTrue(result is Failure && result.value == UserError.UserNotFound) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test get user by token returns user`() {
        val time = System.currentTimeMillis()
        val token = Token(TokenValidationInfo("newToken"), time, time, users[0])
        tokens.add(token)

        val result = userService.getUserByToken(token.token.validationInfo)

        assertTrue(result is Success && result.value.id == 0) {
            if (result is Success) "Expected user id to be 0 but got ${result.value.id}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test get user by token returns token not found`() {
        val time = System.currentTimeMillis()
        val token = Token(TokenValidationInfo("token999999"), time, time, users[0])

        val result = userService.getUserByToken(token.token.validationInfo)

        assertTrue(result is Failure && result.value == UserError.TokenNotFound) {
            "Expected token not found but got $result"
        }
    }

    @Test
    fun `test get user by token returns token expired`() {
        val time = System.currentTimeMillis() - 1000 * 60 * 60 * 24 * 8 // 8 days
        val token = Token(TokenValidationInfo("token"), time, time, users[0])
        tokens.add(token)

        val result = userService.getUserByToken(token.token.validationInfo)

        assertTrue(result is Failure && result.value == UserError.TokenExpired) {
            "Expected token expired but got $result"
        }
    }

    @Test
    fun `test get user by token returns user not found`() {
        val time = System.currentTimeMillis()
        val token = Token(TokenValidationInfo("token999999"), time, time, users[0])
        tokens.add(token)
        users.clear()

        val result = userService.getUserByToken(token.token.validationInfo)

        assertTrue(result is Failure && result.value == UserError.UserNotFound) {
            "Expected user not found but got $result"
        }
    }

    @Test
    fun `test create registration invite`() {
        val result = userService.createRegistrationInvite()

        assertTrue(result is Success){
            "Expected success but got $result"
        }
        if (result is Success) {
            val code = result.value.code
            val isValidInvite = userService.isRegistrationInviteValid(code)
            assertTrue(
                isValidInvite is Success && isValidInvite.value
            ) {
                "Expected success but got $result"
            }
        }
    }

    @Test
    fun `test is registration invite valid returns true`() {
        val code = "code"

        val result = userService.isRegistrationInviteValid(code)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test is registration invite valid returns false`() {
        val code = "code"
        registrationInvites.clear()

        val result = userService.isRegistrationInviteValid(code)

        println(result)
        println(registrationInvites)

        assertTrue(result is Success && !result.value) {
            if (result is Success) "Expected false but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test delete registration invite returns true`() {
        val code = "code"

        val result = userService.deleteRegistrationInvite(code)

        assertTrue(result is Success && result.value) {
            if (result is Success) "Expected true but got ${result.value}"
            else "Expected success but got $result"
        }
    }

    @Test
    fun `test delete registration invite returns false`() {
        val code = "code999999"

        val result = userService.deleteRegistrationInvite(code)

        assertTrue(result is Success && !result.value) {
            if (result is Success) "Expected false but got ${result.value}"
            else "Expected success but got $result"
        }
    }
}
