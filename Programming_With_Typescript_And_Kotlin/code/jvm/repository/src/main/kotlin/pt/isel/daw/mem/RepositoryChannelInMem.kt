package pt.isel.daw.mem

import pt.isel.daw.*

class RepositoryChannelInMem : ChannelRepository {
    val channels = mutableListOf<Channel>()

    override fun createChannel(
        name: String,
        owner: User,
        type: ChannelKind,
        inviteCodeReadOnly: String?,
        inviteCodeWithWrite: String?
    ): Channel =
        Channel.createChannel(channels.count(), name, owner, type, inviteCodeReadOnly, inviteCodeWithWrite)
            .also { channels.add(it) }

    override fun findByName(name: String): Channel? =
        channels.firstOrNull { it.name == name }

    override fun findByInvite(code: String): Channel? =
        channels.firstOrNull { it.inviteCodeReadOnly == code || it.inviteCodeWithWrite == code }

    override fun findById(id: Int): Channel? =
        channels.firstOrNull { it.id == id }

    override fun findAllPublic(): List<Channel> =
        channels.filter { it.type == ChannelKind.PUBLIC }

    override fun findAll(): List<Channel> =
        channels.toList()

    override fun save(entity: Channel) {
        channels.removeIf { it.id == entity.id }
        channels.add(entity)
    }

    override fun deleteById(id: Int) {
        channels.removeIf { it.id == id }
    }

    override fun clear(): Unit = channels.clear()
}
