package pt.isel.daw

interface MessageRepository: Repository<Message> {
    fun createMessage(
        text: String,
        author: Participant
    ): Message
    fun findByChannel(channelId: Int, skip: Int=0, max: Int): List<Message>
    fun findAllByUser(authorId: Int): List<Message>
}
