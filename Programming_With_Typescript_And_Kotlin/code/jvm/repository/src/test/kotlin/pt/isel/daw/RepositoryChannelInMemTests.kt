package pt.isel.daw

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import pt.isel.daw.mem.RepositoryChannelInMem

class RepositoryChannelInMemTests {
    private val repo = RepositoryChannelInMem()
    private val channels = repo.channels
    private val user = User(0, "user1", "email@email.com", PasswordValidationInfo("password"))

    @BeforeEach
    fun setUp() {
        channels.clear()
        channels.add(Channel.createChannel(0, "channel1", user, ChannelKind.PUBLIC, null, null))
        channels.add(Channel.createChannel(1, "channel2", user, ChannelKind.PRIVATE, "read", "write"))
    }

    @Test
    fun `test create channel`() {
        val numChannels = channels.size
        val repo = repo.createChannel("channel3", user, ChannelKind.PUBLIC)
        assert(repo.id == numChannels)
    }

    @Test
    fun `test find by name returns channel`() {
        val channel = repo.findByName(channels[0].name)
        assert(channels[0].name == channel?.name)
    }

    @Test
    fun `test find by name returns null`() {
        val channel = repo.findByName("nonExistentChannel")
        assert(channel == null)
    }

    @Test
    fun `test find by invite returns channel`() {
        val channel = repo.findByInvite(channels[1].inviteCodeReadOnly!!)
        assert(channels[1].inviteCodeReadOnly == channel?.inviteCodeReadOnly)
    }

    @Test
    fun `test find by id returns channel`() {
        val channel = repo.findById(channels[0].id)
        assert(channels[0].id == channel?.id)
    }

    @Test
    fun `test find by id returns null`() {
        val channel = repo.findById(-1)
        assert(channel == null)
    }

    @Test
    fun `test find all public`() {
        val publicChannels = repo.findAllPublic()
        assert(publicChannels.size == channels.filter { it.type == ChannelKind.PUBLIC }.size)
    }

    @Test
    fun `test find all returns all channels`() {
        val channels = repo.findAll()
        assert(channels.size == channels.size)
    }

    @Test
    fun `test save updates channel`() {
        val channel = channels[1]
        val updatedChannel = Channel.createChannel(channel.id, "updatedChannel", user, channel.type, channel.inviteCodeReadOnly, channel.inviteCodeWithWrite)
        repo.save(updatedChannel)
        assert(channels.contains(updatedChannel))
    }

    @Test
    fun `test save adds channel`() {
        val numChannels = channels.size
        val newChannel = Channel.createChannel(9999999, "newChannel", user, ChannelKind.PUBLIC, null, null)
        repo.save(newChannel)
        assert(channels.size == numChannels + 1)
    }

    @Test
    fun `test delete by id removes channel`() {
        val numChannels = channels.size
        repo.deleteById(channels[0].id)
        assert(channels.size == numChannels - 1)
    }

    @Test
    fun `test delete by id does nothing`() {
        val numChannels = channels.size
        repo.deleteById(-1)
        assert(channels.size == numChannels)
    }

    @Test
    fun `test clear removes all channels`() {
        repo.clear()
        assert(channels.isEmpty())
    }
}
