import org.jdbi.v3.core.Handle
import org.jdbi.v3.core.Jdbi
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.postgresql.ds.PGSimpleDataSource
import pt.isel.daw.*
import kotlin.math.abs
import kotlin.random.Random

class RepositoryChannelJdbiTests {
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
            val repoUsers = RepositoryUserJdbi(it)
            val repoChannels = RepositoryChannelJdbi(it)
            repoUsers.clear()
            repoChannels.clear()
            val pass = PasswordValidationInfo("password")
            val user1 = repoUsers
                .createUser("user1", "email@email.com", pass)
            val user2 = repoUsers
                .createUser( "user2", "email2@email.com", pass)
            repoChannels.createChannel("channel1", user1, ChannelKind.PUBLIC, "inviteCodeReadOnly", "inviteCodeWithWrite")
            repoChannels.createChannel("channel2", user2)
        }
    }


    @Test
    fun `test create channel`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val users = RepositoryUserJdbi(it).findAll()
        val user = users[0]
        println(user)
        val channel = repo.createChannel("channel3", user)
        println(channel)
        assertEquals(channel.id, repo.findById(channel.id)?.id)
    }

    @Test
    fun `test find by name returns channel`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        val channel = repo.findByName(channels[0].name)
        assertEquals(channels[0], channel)
    }

    @Test
    fun `test find by name returns null`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channel = repo.findByName("channel999999")
        assertNull(channel)
    }

    @Test
    fun `test find by invite returns channel`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        val channel = repo.findByInvite(channels[0].inviteCodeReadOnly!!)
        assertEquals(channels[0], channel)
    }

    @Test
    fun `test find by invite returns null`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channel = repo.findByInvite("invite999999")
        assertNull(channel)
    }

    @Test
    fun `test find by id returns channel`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        val channel = repo.findById(channels[0].id)
        assertEquals(channels[0], channel)
    }

    @Test
    fun `test find by id returns null`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channel = repo.findById(999999)
        assertNull(channel)
    }

    @Test
    fun `test find all returns all channels`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        assertEquals(channels.size, 2)
    }

    @Test
    fun `test save updates channel`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        val channel = channels[0]
        repo.save(Channel(channel.id, "channel3", channel.owner, channel.type, null, null))
        val updatedChannel = repo.findById(channel.id)
        assertEquals("channel3", updatedChannel?.name)
    }

    @Test
    fun `test delete channel by id`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val channels = repo.findAll()
        val numChannels = channels.size
        repo.deleteById(channels[0].id)
        val updatedChannels = repo.findAll()
        assertEquals(numChannels - 1, updatedChannels.size)
    }

    @Test
    fun `test delete channel by id does not delete anything`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        val numChannels = repo.findAll().size
        repo.deleteById(999999)
        assertEquals(numChannels, repo.findAll().size)
    }

    @Test
    fun `test clear clears all channels`() = runWithHandle {
        val repo = RepositoryChannelJdbi(it)
        repo.clear()
        assertEquals(0, repo.findAll().size)
    }
}