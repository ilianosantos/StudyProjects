package pt.isel.daw

sealed interface NewMessageEmitter {
    data class Text(
        val id: Int,
        val message: Message,
    ) : NewMessageEmitter
    data object KeepAlive : NewMessageEmitter
}