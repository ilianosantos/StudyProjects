package pt.isel.daw

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.*

class RepositoryMessageInMemTests {
    private val repo = RepositoryMessageInMem()
    private val messages = repo.messages
    private val user = User(0, "user1", "email@email.com", PasswordValidationInfo("password"))
    private val channel = Channel(0, "channel1", user, ChannelKind.PUBLIC, null, null)
    private val participant = Participant(0, user, channel, ParticipantKind.WRITER)

    @BeforeEach
    fun setUp() {
        messages.clear()
        messages.add(Message(0, "message1", participant))
        messages.add(Message(1, "message2", participant))
    }

    @Test
    fun `test create message`() {
        val message = repo.createMessage("message3", participant)
        assert(message.id == messages.last().id)
    }

    @Test
    fun `test find by id returns message`() {
        val message = repo.findById(0)
        assert(message == messages[0])
    }

    @Test
    fun `test find by id returns null`() {
        val message = repo.findById(2)
        assert(message == null)
    }

    @Test
    fun `test find all returns all messages`() {
        val allMessages = repo.findAll()
        assert(allMessages.size == messages.size)
    }

    @Test
    fun `test find by channel returns messages`() {
        val skip = 1
        val max = 2

        val channelMessages = repo.findByChannel(0, skip, max)

        val expected = if (skip + max > messages.size) messages.size - skip else max
        assert(channelMessages.size == expected) {
            "Expected $expected messages, but got ${channelMessages.size}"
        }
        assert(channelMessages == messages.drop(skip).take(max)) {
            "Expected ${messages.drop(skip).take(max)}, but got $channelMessages"
        }
    }

    @Test
    fun `test save updates message`() {
        val message = Message(0, "message3", participant)
        repo.save(message)
        assert(messages.contains(message))
    }

    @Test
    fun `test delete message deletes message`() {
        val numMessages = messages.size
        repo.deleteById(0)
        assert(messages.size == numMessages - 1)
    }

    @Test
    fun `test delete message by id does not delete anything`() {
        val numMessages = messages.size
        repo.deleteById(2)
        assert(messages.size == numMessages)
    }

    @Test
    fun `test clear messages`() {
        repo.clear()
        assert(messages.isEmpty())
    }
}
