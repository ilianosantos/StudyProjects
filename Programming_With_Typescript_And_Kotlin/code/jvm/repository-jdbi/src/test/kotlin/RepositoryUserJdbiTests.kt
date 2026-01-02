import org.jdbi.v3.core.Handle
import org.jdbi.v3.core.Jdbi
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.postgresql.ds.PGSimpleDataSource
import pt.isel.daw.*
import kotlin.math.abs
import kotlin.random.Random

class RepositoryUserJdbiTests {
    private fun newTokenValidationData() = "token-${abs(Random.nextLong())}"
    companion object {
        private fun runWithHandle(block: (Handle) -> Unit) =
            jdbi.useTransaction<Exception>(block)

        private val jdbi =
            Jdbi
                .create(
                    PGSimpleDataSource().apply {
                        setURL(Environment.getDbUrl())
                    },
                ).configureWithAppRequirements()
    }

    @BeforeEach
    fun setUp() {
        runWithHandle {
            val repo = RepositoryUserJdbi(it)
            repo.clear()
            val pass = PasswordValidationInfo("password")
            repo
                .createUser("user1", "email@email.com", pass)
            repo
                .createUser( "user2", "email2@email.com", pass)
        }
    }

    @Test
    fun `test create user`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val pass = PasswordValidationInfo("password")
        val user = repo.createUser("user3", "email3@email.com", pass)
        assertEquals(user.id, repo.findById(user.id)?.id)
    }

    @Test
    fun `test find by username returns user`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val pass = PasswordValidationInfo("password")
        val createdUser = repo.createUser("user3", "user@gmail.com", pass)
        val user = repo.findByUsername("user3")
        assertEquals(createdUser, user)
    }

    @Test
    fun `test find by username returns null`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val user = repo.findByUsername("user999999")
        assertNull(user)
    }

    @Test
    fun `test find by email returns user`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val user = repo.findByEmail(users[0].email)
        assertEquals(users[0], user)
    }

    @Test
    fun `test find by email returns null`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val user = repo.findByEmail("email999999")
        assertNull(user)
    }

    @Test
    fun `test find by id returns user`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val user = repo.findById(users[0].id)
        assertEquals(users[0], user)
    }

    @Test
    fun `test find by id returns null`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val user = repo.findById(999999)
        assertNull(user)
    }

    @Test
    fun `test find all returns all users`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        assertEquals(2, users.size)
    }

    @Test
    fun `test save updates user`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val size = users.size
        val user = repo.findByEmail("email@email.com")
        assertNotNull(user)
        val updatedUser = User(user!!.id, "joão", user.email, PasswordValidationInfo("password"))
        repo.save(updatedUser)
        assertEquals(size, users.size)
    }

    @Test
    fun `test delete user by id`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val numUsers = users.size
        repo.deleteById(users[numUsers-1].id)
        assertEquals(numUsers - 1, repo.findAll().size)
    }

    @Test
    fun `test delete user by id does not delete anything`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val numUsers = users.size
        repo.deleteById(999999)
        assert(users.size == numUsers)
    }

    @Test
    fun `test clear clears all users`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        repo.save(User(0, "user1", "email1", PasswordValidationInfo("password")))
        repo.save(User(1, "user2", "email2", PasswordValidationInfo("password")))
        repo.clear()
        val users = repo.findAll()
        assert(users.isEmpty())
    }

    @Test
    fun `test create token`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        assertTrue(repo.createToken(tok))
        val createdToken = repo.getTokenByValidationInfo(tok.token)
        println(createdToken)
        assertEquals(tok, createdToken)
    }

    @Test
    fun `test create token returns null`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        repo.createToken(tok)
        val createdToken = repo.createToken(tok)
        assertFalse(createdToken)
    }

    @Test
    fun `test get token by validation info returns token`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        repo.createToken(tok)
        val tokenJdbi = repo.getTokenByValidationInfo(tok.token)
        assertEquals(tok, tokenJdbi)
    }

    @Test
    fun `test get token by validation info returns null`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        val tokenJdbi = repo.getTokenByValidationInfo(tok.token)
        assertNull(tokenJdbi)
    }

    @Test
    fun `test get all user tokens returns all tokens`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        repo.createToken(tok)
        val tokens = repo.getAllUserTokens(users[0])
        assertEquals(1, tokens.size)
    }

    @Test
    fun `test remove token by validation info removes token`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        repo.createToken(tok)
        val removed = repo.removeTokenByValidationInfo(tok.token)
        assertTrue(removed)
    }

    @Test
    fun `test remove token by validation info doesnt remove anything`() = runWithHandle {
        val repo = RepositoryUserJdbi(it)
        val users = repo.findAll()
        val tvi = TokenValidationInfo(newTokenValidationData())
        val clk = System.currentTimeMillis()
        val tok = Token(tvi, clk, clk, users[0])
        val removed = repo.removeTokenByValidationInfo(tok.token)
        assertFalse(removed)
    }
}