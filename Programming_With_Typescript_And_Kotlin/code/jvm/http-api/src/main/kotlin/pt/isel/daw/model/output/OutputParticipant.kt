package pt.isel.daw.model.output

import pt.isel.daw.Participant
import pt.isel.daw.ParticipantKind

class OutputParticipant (
    val id: Int,
    val user: OutputUser,
    val channel: OutputChannel,
    val type: ParticipantKind
)

fun Participant.toOutputParticipant() = OutputParticipant(
    id = id,
    user = user.toOutputUser(),
    channel = channel.toOutputChannel(),
    type = type,
)
