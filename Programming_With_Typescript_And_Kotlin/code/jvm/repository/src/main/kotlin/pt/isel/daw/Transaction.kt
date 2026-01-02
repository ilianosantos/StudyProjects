package pt.isel.daw

interface Transaction {
    val repoMessages: MessageRepository
    val repoChannels: ChannelRepository
    val repoUsers: UserRepository
    val repoParticipants: ParticipantRepository

    fun rollback()
}