package pt.isel.daw

interface TransactionManager {
    fun <R> run(block: Transaction.() -> R) : R
}