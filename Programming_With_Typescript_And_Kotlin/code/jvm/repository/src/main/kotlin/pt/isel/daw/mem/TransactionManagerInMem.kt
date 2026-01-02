package pt.isel.daw.mem

import pt.isel.daw.*

class TransactionManagerInMem : TransactionManager {
    val repoMessages = RepositoryMessageInMem()
    val repoUsers = RepositoryUserInMem()
    val repoChannels = RepositoryChannelInMem()
    val repoParticipants = RepositoryParticipantInMem()

    override fun <R> run(block: Transaction.() -> R): R {
        return block(TransactionInMem(repoMessages, repoUsers, repoChannels, repoParticipants))
    }
}
