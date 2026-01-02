package pt.isel.daw

interface UpdatedChannelEmitter {
    val userId: Int
    fun emit(signal: NewMessageEmitter)
    fun onCompletion(callback: () -> Unit)
    fun onError(callback: (Throwable) -> Unit)
}
