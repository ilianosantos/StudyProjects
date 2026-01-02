package pt.isel.daw

enum class ParticipantKind {
    OWNER, WRITER, READER_ONLY
}

data class Participant (
    val id: Int,
    val user: User,
    val channel: Channel,
    val type: ParticipantKind
)
