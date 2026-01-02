package pt.isel.daw.model.output

data class OutputCreateChannel (
    val channelId: Int,
    val inviteReadOnly: String?,
    val inviteWithWrite: String?
)