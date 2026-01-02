package pt.isel.daw

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.*

class RepositoryParticipantInMemTests {
    private val repo = RepositoryParticipantInMem()
    private val participants = repo.participants
    private val user = User(0, "user1", "email@email.com", PasswordValidationInfo("password"))
    private val channel = Channel(0, "channel1", user, ChannelKind.PUBLIC, null, null)

    @BeforeEach
    fun setUp() {
        participants.clear()
        participants.add(Participant(0, user, channel, ParticipantKind.WRITER))
    }

    @Test
    fun `test create participant`() {
        val user = user.copy(id = 1)
        val newParticipant = repo.createParticipant(user, channel, ParticipantKind.WRITER)
        assert(newParticipant.id == participants.last().id)
    }

    @Test
    fun `test find all by channel returns all participants`() {
        var participantsNum = 0
        participants.forEach { if (it.channel == channel) participantsNum++ }
        val allParticipants = repo.findAllByChannel(channel.id)
        assert(allParticipants.size == participantsNum)
    }

    @Test
    fun `test find all by user id returns all participants`() {
        var participantsNum = 0
        participants.forEach { if (it.user == user) participantsNum++ }
        val allParticipants = repo.findAllByUserId(user.id)
        assert(allParticipants.size == participantsNum)
    }

    @Test
    fun `test find by id returns participant`() {
        val participant = repo.findById(0)
        assert(participant == participants[0])
    }

    @Test
    fun `test find by id returns null`() {
        val participant = repo.findById(999999)
        assert(participant == null)
    }

    @Test
    fun `test find all returns all participants`() {
        val allParticipants = repo.findAll()
        assert(allParticipants.size == participants.size)
    }

    @Test
    fun `test find by channel and name returns participant`() {
        val participant = repo.findByChannelAndId(channel.id, 0)
        assert(participant == participants[0])
    }

    @Test
    fun `test find by channel and name returns null`() {
        val participant = repo.findByChannelAndId(channel.id, 1)
        assert(participant == null)
    }

    @Test
    fun `test delete by channel and id deletes participant`() {
        val numParticipants = participants.size
        repo.deleteByChannelAndId(channel.id, 0)
        assert(participants.size == numParticipants - 1)
        participants.forEach{ assert(it.id != 0) }
    }

    @Test
    fun `test save updates participant`() {
        val participant = Participant(0, user, channel, ParticipantKind.WRITER)
        repo.save(participant)
        assert(participants.contains(participant))
    }

    @Test
    fun `test delete participant deletes participant`() {
        val numParticipants = participants.size
        repo.deleteById(0)
        assert(participants.size == numParticipants - 1)
        participants.forEach{ assert(it.id != 0) }
    }

    @Test
    fun `test delete participant by id does not delete anything`() {
        val numParticipants = participants.size
        repo.deleteById(999999)
        assert(participants.size == numParticipants)
    }

    @Test
    fun `test clear participants`() {
        repo.clear()
        assert(participants.isEmpty())
    }
}
