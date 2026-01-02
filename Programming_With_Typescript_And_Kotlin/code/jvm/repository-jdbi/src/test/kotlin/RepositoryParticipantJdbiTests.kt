import org.jdbi.v3.core.Handle
import org.jdbi.v3.core.Jdbi
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.postgresql.ds.PGSimpleDataSource
import pt.isel.daw.*

class RepositoryParticipantJdbiTests {
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
            repoUsers.clear()
            repoChannels.clear()
            repoParticipants.clear()
            val pass = PasswordValidationInfo("password")
            val user1 = repoUsers
                .createUser("user1", "user1@email.com", pass)
            val user2 = repoUsers
                .createUser( "user2", "user2@email.com", pass)
            val ch1 = repoChannels.createChannel("channel1", user1)
            val ch2 = repoChannels.createChannel("channel2", user2)
            repoParticipants.createParticipant(user1, ch1, ParticipantKind.OWNER)
            repoParticipants.createParticipant(user2, ch2, ParticipantKind.OWNER)
        }
    }

//    @Test
//    fun `test find by id and channel returns participant`() = runWithHandle {
//        val repo = RepositoryParticipantJdbi(it)
//        val participants = repo.findAll()
//        val participant = repo.findByChannelAndId(participants[0].id, participants[0].user.id)
//        assertEquals(participants[0], participant)
//    }

    @Test
    fun `test find by id  and channel returns null`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val channel = repo.findByChannelAndId(999999, 999999)
        assertNull(channel)
    }

    @Test
    fun `test create participant`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val user = RepositoryUserJdbi(it).findAll()[0]
        val channel = RepositoryChannelJdbi(it).findAll()[1]
        val participant = repo.createParticipant(user, channel, ParticipantKind.READER_ONLY)
        assertNotNull(participant)
    }

    @Test
    fun `test find by id returns participant`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAll()
        val participant = repo.findById(participants[0].id)
        assertEquals(participants[0], participant)
    }

    @Test
    fun `test find by id returns null`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participant = repo.findById(999999)
        assertNull(participant)
    }

    @Test
    fun `test find all by channel returns participant`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAllByChannel(repo.findAll()[0].channel.id)
        assertEquals(1, participants.size)
    }

    @Test
    fun `test find all by channel returns null`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAllByChannel(999999)
        assertTrue(participants.isEmpty())
    }


    @Test
    fun `test find all by userId returns participant`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAllByUserId(repo.findAll()[0].user.id)
        assertEquals(1, participants.size)
    }

    @Test
    fun `test find all by userId returns null`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAllByUserId(999999)
        assertTrue(participants.isEmpty())
    }

    @Test
    fun `test delete all by channel and id`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAll()
        val participant = participants[0]
        repo.deleteByChannelAndId(participant.channel.id, participant.user.id)
        assertTrue(repo.findAll().none { it.id == participant.id })
    }

    @Test
    fun `test find all returns all participants`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participants = repo.findAll()
        assertEquals(2, participants.size)
    }

    @Test
    fun `test save updates participant`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val participant = repo.findAll()[0]
        val newParticipant = participant.copy(type = ParticipantKind.READER_ONLY)
        repo.save(newParticipant)
        assertEquals(newParticipant.id, repo.findById(participant.id)?.id)
        assertEquals(newParticipant.type, repo.findById(participant.id)?.type)
    }

    @Test
    fun `test delete participant by id`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val numChannels = repo.findAll().size
        val channel = repo.findAll()[0]
        repo.deleteById(channel.id)
        assertEquals(numChannels - 1, repo.findAll().size)
    }

    @Test
    fun `test delete participant by id does not delete anything`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        val numChannels = repo.findAll().size
        repo.deleteById(999999)
        assertEquals(numChannels, repo.findAll().size)
    }

    @Test
    fun `test clear clears all participants`() = runWithHandle {
        val repo = RepositoryParticipantJdbi(it)
        repo.clear()
        assertEquals(0, repo.findAll().size)
    }
}