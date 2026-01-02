package pt.isel.daw

import java.util.*

enum class ChannelKind {
    PUBLIC,
    PRIVATE
}

data class Channel (
    val id: Int,
    val name: String,
    val owner: User,
    val type: ChannelKind,
    val inviteCodeWithWrite: String?,
    val inviteCodeReadOnly: String?
) {
    init {
        require(name.isNotBlank()) { "Name must not be blank" }
        require(owner.name.isNotBlank()) { "Owner name must not be blank" }
    }

    companion object {
        fun generateInviteCode() : String = UUID.randomUUID().toString()

        fun createChannel(
            id: Int,
            name: String,
            owner: User,
            type: ChannelKind,
            inviteCodeReadOnly: String?,
            inviteCodeWithWrite: String?
        ) : Channel = Channel(
                id = id,
                name = name,
                owner = owner,
                type = type,
                inviteCodeReadOnly = inviteCodeReadOnly,
                inviteCodeWithWrite = inviteCodeWithWrite
            )
    }

    override fun toString(): String =
        "Channel(id=$id, name='$name', owner=${owner.name}, type=$type)"
}
