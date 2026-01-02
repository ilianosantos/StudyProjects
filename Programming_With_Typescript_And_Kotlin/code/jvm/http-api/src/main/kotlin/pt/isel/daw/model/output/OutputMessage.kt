package pt.isel.daw.model.output

import pt.isel.daw.Message
import java.sql.Timestamp

class OutputMessage(
    val id: Int,
    val text: String,
    val author: OutputParticipant,
    val time: Timestamp = Timestamp(System.currentTimeMillis())
)

fun Message.toOutputMessage() = OutputMessage(
    id = id,
    text = text,
    author = author.toOutputParticipant(),
    time = time
)
