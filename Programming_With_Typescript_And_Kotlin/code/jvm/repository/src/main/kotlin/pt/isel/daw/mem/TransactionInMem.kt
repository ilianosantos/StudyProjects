package pt.isel.daw.mem

import pt.isel.daw.*

class TransactionInMem(
    override val repoMessages: MessageRepository,
    override val repoUsers: UserRepository,
    override val repoChannels: ChannelRepository,
    override val repoParticipants: ParticipantRepository
) : Transaction {

    override fun rollback() {
        throw UnsupportedOperationException()
    }
}