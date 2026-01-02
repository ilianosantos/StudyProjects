package pt.isel.daw

import java.sql.Timestamp

data class Message(
    val id: Int,
    val text: String,
    val author: Participant,
    val time: Timestamp = Timestamp(System.currentTimeMillis())
) {
    init {
        require(text.isNotBlank()) { "Text must not be blank" }
    }

    override fun toString(): String =
        "Message(id=$id, text='$text', author=${author.user.name}, channel=${author.channel.name})"
}
