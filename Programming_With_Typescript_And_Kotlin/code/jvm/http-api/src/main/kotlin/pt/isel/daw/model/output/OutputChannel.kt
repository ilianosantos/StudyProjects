package pt.isel.daw.model.output

import pt.isel.daw.Channel
import pt.isel.daw.ChannelKind

data class OutputChannel (
    val id: Int,
    val name: String,
    val owner: OutputUser,
    val type: ChannelKind,
    val inviteCodeWithWrite: String?,
    val inviteCodeReadOnly: String?,
)

fun Channel.toOutputChannel() = OutputChannel(
    id = id,
    name = name,
    owner = owner.toOutputUser(),
    type = type,
    inviteCodeWithWrite = inviteCodeWithWrite,
    inviteCodeReadOnly = inviteCodeReadOnly,
)
