import org.jdbi.v3.core.Handle
import org.jdbi.v3.core.Jdbi
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.postgresql.ds.PGSimpleDataSource
import pt.isel.daw.*

class RepositoryMessageJdbiTests {
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
            val repoParticipants = RepositoryParticipantJdbi(it)
            val repoMessages = RepositoryMessageJdbi(it)
            repoUsers.clear()
            repoChannels.clear()
            repoParticipants.clear()
            repoMessages.clear()
            val pass = PasswordValidationInfo("password")
            val user1 = repoUsers
                .createUser("user1", "user1@email.com", pass)
            val user2 = repoUsers
                .createUser( "user2", "user2@email.com", pass)
            val ch1 = repoChannels.createChannel("channel1", user1)
            val ch2 = repoChannels.createChannel("channel2", user2)
            val part1 = repoParticipants.createParticipant(user1, ch1, ParticipantKind.OWNER)
            val part2 = repoParticipants.createParticipant(user2, ch2, ParticipantKind.OWNER)
            repoMessages.createMessage( "message1", part1)
            repoMessages.createMessage( "message2", part2)
        }
    }

    @Test
    fun `test create message`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val part = RepositoryParticipantJdbi(it)
        val participants = part.findAll()
        val message = repo.createMessage("message3", participants[0])
        assertEquals("message3", message.text)
    }

    @Test
    fun `test find by id returns message`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val message = repo.findAll()[0]
        assertEquals(message, repo.findById(message.id))
    }

    @Test
    fun `test find by id returns null`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        assertNull(repo.findById(999999))
    }

    @Test
    fun `test find all returns all messages`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        assertEquals(2, repo.findAll().size)
    }

    @Test
    fun `test find by channel returns messages skipping 1`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val channels = RepositoryChannelJdbi(it).findAll()
        // create a message in the first channel
        val participants = RepositoryParticipantJdbi(it).findAll()
        repo.createMessage("message3", participants[0])
        val messages = repo.findByChannel(channels[0].id, 1, 10)
        assertEquals(1, messages.size)
    }

    @Test
    fun `test find by channel returns messages with a maximum of 1`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val channels = RepositoryChannelJdbi(it).findAll()
        val participants = RepositoryParticipantJdbi(it).findAll()
        repo.createMessage("message3", participants[0])
        val messages = repo.findByChannel(channels[0].id, 1, 1)
        assertEquals(1, messages.size)
    }

    @Test
    fun `test save updates messages`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val message = repo.findAll()[0]
        repo.save(message.copy(text = "new message"))
        assertEquals("new message", repo.findById(message.id)?.text)
    }

    @Test
    fun `test delete message by id`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val numMessages = repo.findAll().size
        val message = repo.findAll()[0]
        repo.deleteById(message.id)
        assertEquals(numMessages - 1, repo.findAll().size)
    }

    @Test
    fun `test delete message by id does not delete anything`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        val numMessages = repo.findAll().size
        repo.deleteById(999999)
        assertEquals(numMessages, repo.findAll().size)
    }

    @Test
    fun `test clear clears all messages`() = runWithHandle {
        val repo = RepositoryMessageJdbi(it)
        repo.clear()
        assertTrue(repo.findAll().isEmpty())
    }
}