package pt.isel.daw

import org.jdbi.v3.core.Handle

class TransactionJdbi(
    private val handle: Handle,
) : Transaction {
    override val repoMessages = RepositoryMessageJdbi(handle)
    override val repoUsers = RepositoryUserJdbi(handle)
    override val repoChannels = RepositoryChannelJdbi(handle)
    override val repoParticipants = RepositoryParticipantJdbi(handle)

    override fun rollback() {
        handle.rollback()
    }
}