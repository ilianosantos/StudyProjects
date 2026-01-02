package pt.isel.daw

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.RepositoryUserInMem
import kotlin.math.abs
import kotlin.random.Random

private fun newTokenValidationData() = "token-${abs(Random.nextLong())}"

class RepositoryUserInMemTests {
    private val repo = RepositoryUserInMem()
    private val registrationInvites = repo.registrationInvites
    private val users = repo.users
    private val tokens = repo.tokens

    @BeforeEach
    fun setUp() {
        registrationInvites.clear()
        tokens.clear()
        users.clear()
        val pass = PasswordValidationInfo("password")
        users.add(User(0, "user1", "email@email.com", pass))
        users.add(User(1, "user2", "email2@email.com", pass))
        tokens.add(Token(TokenValidationInfo(newTokenValidationData()), 0, 0, users[0]))
        tokens.add(Token(TokenValidationInfo(newTokenValidationData()), 0, 0, users[1]))
        registrationInvites.add(RegistrationInvite("code"))
    }

    @Test
    fun `test create user`() {
        val pass = PasswordValidationInfo("password")
        val user = repo.createUser("user3", "email3@email.com", pass)
        assert(user.id == users.last().id)
    }

    @Test
    fun `test find by username returns user`() {
        val user = repo.findByUsername(users[0].name)
        assert(user == users[0])
    }

    @Test
    fun `test find by username returns null`() {
        val user = repo.findByUsername("user999999")
        assert(user == null)
    }

    @Test
    fun `test find by email returns user`() {
        val user = repo.findByEmail(users[0].email)
        assert(user == users[0])
    }

    @Test
    fun `test find by email returns null`() {
        val user = repo.findByEmail("email999999")
        assert(user == null)
    }

    @Test
    fun `test find by id returns user`() {
        val user = repo.findById(users[0].id)
        assert(user == users[0])
    }

    @Test
    fun `test find by id returns null`() {
        val user = repo.findById(999999)
        assert(user == null)
    }

    @Test
    fun `test find all returns all users`() {
        val allUsers = repo.findAll()
        assert(allUsers.size == users.size)
    }

    @Test
    fun `test save updates user`() {
        val numUsers = users.size
        val pass = PasswordValidationInfo("password")
        val user = User(0, "anotherUser", "another@email.com", pass)
        repo.save(user)
        assert(users.contains(user))
        assert(users.size == numUsers)
    }

    @Test
    fun `test delete user deletes user`() {
        val numUsers = users.size
        repo.deleteById(0)
        assert(users.size == numUsers - 1)
    }

    @Test
    fun `test delete user by id does not delete anything`() {
        val numUsers = users.size
        repo.deleteById(999999)
        assert(users.size == numUsers)
    }

    @Test
    fun `test clear clears all users`() {
        repo.clear()
        assert(users.isEmpty())
    }

    @Test
    fun `test create token`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        val createdToken = repo.createToken(token)
        val tokenInMem = tokens.last()
        assert(createdToken && token == tokenInMem)
    }

    @Test
    fun `test create token returns null`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        repo.createToken(token)
        val createdToken = repo.createToken(token)
        assert(!createdToken)
    }

    @Test
    fun `test get token by validation info returns token`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        repo.createToken(token)
        val tokenInMem = repo.getTokenByValidationInfo(token.token)
        assert(token == tokenInMem)
    }

    @Test
    fun `test get token by validation info returns null`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        val tokenInMem = repo.getTokenByValidationInfo(token.token)
        assert(tokenInMem == null)
    }

    @Test
    fun `test get all user tokens`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        repo.createToken(token)
        val userTokens = repo.getAllUserTokens(users[0])
        assert(userTokens.size == tokens.filter { it.user == users[0] }.size)
    }

    @Test
    fun `test remove token by validation info removes token`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        repo.createToken(token)
        val removed = repo.removeTokenByValidationInfo(token.token)
        assert(removed)
    }

    @Test
    fun `test remove token by validation info doesnt remove anything`() {
        val tvi = TokenValidationInfo(newTokenValidationData())
        val time = System.currentTimeMillis()
        val token = Token(tvi, time, time, users[0])
        val removed = repo.removeTokenByValidationInfo(token.token)
        assert(!removed)
    }

    @Test
    fun `test create registration invite`() {
        val invite = RegistrationInvite("code2")
        val created = repo.createRegistrationInvite(invite)
        assert(created)
    }

    @Test
    fun `test get registration invite returns invite`() {
        val inviteCode = "code"
        val inviteInMem = repo.getRegistrationInvite(inviteCode)
        assert(inviteCode == inviteInMem?.code)
    }

    @Test
    fun `test get registration invite returns null`() {
        val inviteCode = "code2"
        val inviteInMem = repo.getRegistrationInvite(inviteCode)
        assert(inviteInMem == null)
    }

    @Test
    fun `test delete registration invite`() {
        val inviteCode = "code"
        val deleted = repo.deleteRegistrationInvite(inviteCode)
        assert(deleted)
    }

    @Test
    fun `test delete registration invite doesnt delete anything`() {
        val inviteCode = "code2"
        val deleted = repo.deleteRegistrationInvite(inviteCode)
        assert(!deleted)
    }
}
