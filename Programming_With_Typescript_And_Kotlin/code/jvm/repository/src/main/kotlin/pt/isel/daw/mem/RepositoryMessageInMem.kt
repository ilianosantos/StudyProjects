package pt.isel.daw.mem

import pt.isel.daw.*


class RepositoryMessageInMem : MessageRepository {
    val messages = mutableListOf<Message>()

    override fun createMessage(
        text: String,
        author: Participant
    ): Message = Message(messages.count(), text, author).also { messages.add(it) }

    override fun findById(id: Int): Message? {
        return messages.firstOrNull { it.id == id }
    }

    override fun findAll(): List<Message> {
        return messages.toList()
    }

    override fun findByChannel(channelId: Int, skip: Int, max: Int): List<Message> =
        messages.filter { it.author.channel.id == channelId }.sortedBy { it.time }.drop(skip).take(max)

    override fun findAllByUser(authorId: Int) =
        messages.filter { it.author.user.id == authorId }

    override fun save(entity: Message) {
        messages.removeIf { it.id == entity.id }
        messages.add(entity)
    }

    override fun deleteById(id: Int) {
        messages.removeIf { it.id == id }
    }

    override fun clear() { messages.clear() }
}
