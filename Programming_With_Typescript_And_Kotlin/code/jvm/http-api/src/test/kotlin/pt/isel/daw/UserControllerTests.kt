package pt.isel.daw

import kotlinx.datetime.Clock
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.http.HttpHeaders
import pt.isel.daw.controllers.UserController
import pt.isel.daw.mem.*
import pt.isel.daw.model.input.InputCreateUser
import pt.isel.daw.model.input.LoginInput
import pt.isel.daw.model.output.UserHomeOutputModel

class UserControllerTests {
    private val transactionManager = TransactionManagerInMem()
    private val userService = UserService(transactionManager)
    private val userController = UserController(userService)
    private val registrationInvites = transactionManager.repoUsers.registrationInvites
    private val users = transactionManager.repoUsers.users
    private val tokens = transactionManager.repoUsers.tokens

    @BeforeEach
    fun setUp() {
        users.clear()
        users.add(User(0, "user1", "email1@email.com", PasswordValidationInfo(HashEncoder.hash("password"))))
        users.add(User(1, "user2", "email2@email.com", PasswordValidationInfo(HashEncoder.hash("password"))))
    }

    @Test
    fun `test create user returns user`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val inputUser = InputCreateUser("test1", "test1@email.com", "Password123!")
        val result = userController.createUser(code, inputUser)

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
    }

    @Test
    fun `test create user returns invalid registration invite`() {
        val inputUser = InputCreateUser("test2", "test2@email.com", "password123")
        val result = userController.createUser("invalidCode", inputUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("InvalidRegistrationInvite", result.body?.toString() ?: "") {
                "Expected 'InvalidRegistrationInvite' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test create user returns need not null parameters`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))

        // Null name
        val inputUser1 = InputCreateUser("", "test3email.com", "password123")
        val result1 = userController.createUser(code, inputUser1)

        assertEquals(400, result1.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result1.statusCode}"
        }
        assertNotNull(result1.body) { "Expected non-null response body" }
        result1.body?.let {
            assertEquals("NeedNotNullParameters", result1.body?.toString() ?: "") {
                "Expected 'NeedNotNullParameters' but got ${result1.body}"
            }
        }

        // Null email
        val inputUser2 = InputCreateUser("test3", "", "password123")
        val result2 = userController.createUser(code, inputUser2)

        assertEquals(400, result2.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result2.statusCode}"
        }
        assertNotNull(result2.body) { "Expected non-null response body" }
        result2.body?.let {
            assertEquals("NeedNotNullParameters", result2.body?.toString() ?: "") {
                "Expected 'NeedNotNullParameters' but got ${result2.body}"
            }
        }

        // Null password
        val inputUser3 = InputCreateUser("test3", "test3email.com", "")
        val result3 = userController.createUser(code, inputUser3)

        assertEquals(400, result3.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result3.statusCode}"
        }
        assertNotNull(result3.body) { "Expected non-null response body" }
        result3.body?.let {
            assertEquals("NeedNotNullParameters", result3.body?.toString() ?: "") {
                "Expected 'NeedNotNullParameters' but got ${result3.body}"
            }
        }
    }

    @Test
    fun `test create user returns password too weak`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val inputUser = InputCreateUser("Name", "test3email.com", "weak")
        val result = userController.createUser(code, inputUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("PasswordTooWeak", result.body?.toString() ?: "") {
                "Expected 'PasswordTooWeak' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test create user returns invalid email`() {
        val code = "validCode"
        registrationInvites.add(RegistrationInvite(code))
        val inputUser = InputCreateUser("Name", "test3email.com", "Password123!")
        val result = userController.createUser(code, inputUser)

        assertEquals(400, result.statusCode.value()) {
            "Expected status code to be 400 Bad Request but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("InvalidEmail", result.body?.toString() ?: "") {
                "Expected 'InvalidEmail' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test create user returns user already exists`() {
        val code = "validCode"
        val existingUser = users[0]
        registrationInvites.add(RegistrationInvite(code))
        val inputUser = InputCreateUser(existingUser.name, "test@email.com", "Password123!")
        val result = userController.createUser(code, inputUser)

        assertEquals(409, result.statusCode.value()) {
            "Expected status code to be 409 Conflict but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("UserAlreadyExists", result.body?.toString() ?: "") {
                "Expected 'UserAlreadyExists' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test create user returns email already in use`() {
        val code = "validCode"
        val existingUser = users[0]
        registrationInvites.add(RegistrationInvite(code))
        val inputUser = InputCreateUser("NewName", existingUser.email, "Password123!")
        val result = userController.createUser(code, inputUser)

        assertEquals(409, result.statusCode.value()) {
            "Expected status code to be 409 Conflict but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
        result.body?.let {
            assertEquals("EmailAlreadyInUse", result.body?.toString() ?: "") {
                "Expected 'EmailAlreadyInUse' but got ${result.body}"
            }
        }
    }

    @Test
    fun `test create registration invite`() {
        val result = userController.createRegistrationInvite(AuthenticatedUser(users[0], "validToken"))

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertNotNull(result.body) { "Expected non-null response body" }
    }

    @Test
    fun `test get user home`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")

        val result = userController.getUserHome(authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }
        assertEquals(UserHomeOutputModel(user.id, user.name, user.email), result.body)
    }

    @Test
    fun `test login returns token`() {
        val loginInput = LoginInput("user1", "password")
        val result = userController.login(loginInput)

        assertEquals(201, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }

        val setCookieHeader = result.headers[HttpHeaders.SET_COOKIE]
        assertNotNull(setCookieHeader) { "Expected Set-Cookie header to be present" }
    }

    @Test
    fun `test login returns unauthorized`() {
        // Non-existent user
        val loginInput1 = LoginInput("user999999", "password")
        val result1 = userController.login(loginInput1)

        assertEquals(401, result1.statusCode.value()) { "Expected status code to be 401 Unauthorized but got ${result1.statusCode}" }

        // Wrong password
        val loginInput2 = LoginInput("user1", "wrongPass")
        val result2 = userController.login(loginInput2)

        assertEquals(401, result2.statusCode.value()) { "Expected status code to be 401 Unauthorized but got ${result2.statusCode}" }

        // Null username
        val loginInput3 = LoginInput("", "wrongPass")
        val result3 = userController.login(loginInput3)

        assertEquals(401, result3.statusCode.value()) { "Expected status code to be 401 Unauthorized but got ${result3.statusCode}" }

        // Null password
        val loginInput4 = LoginInput("user1", "wrongPass")
        val result4 = userController.login(loginInput4)

        assertEquals(401, result4.statusCode.value()) { "Expected status code to be 401 Unauthorized but got ${result4.statusCode}" }
    }

    @Test
    fun `test logout user`() {
        val user = users[0]
        val authUser = AuthenticatedUser(user, "validToken")

        tokens.add(Token(TokenValidationInfo("validToken"), Clock.System.now().toEpochMilliseconds(), Clock.System.now().toEpochMilliseconds(), user))

        val result = userController.logout(authUser)

        assertEquals(200, result.statusCode.value()) {
            "Expected success status code but got ${result.statusCode}"
        }

        val setCookieHeader = result.headers[HttpHeaders.SET_COOKIE]
        assertNotNull(setCookieHeader) { "Expected Set-Cookie header to be present" }
    }
}
