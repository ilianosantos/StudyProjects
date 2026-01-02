package pt.isel.daw

import java.util.*

data class Token(
    val token: TokenValidationInfo,
    val createdAt: Long,
    val lastUsedAt: Long,
    val user: User
) {
    init {
        require(token.validationInfo.isNotBlank()) { "Token must not be blank" }
    }

    fun updateLastUsedAt() = copy(lastUsedAt = System.currentTimeMillis())

    fun isExpired() = System.currentTimeMillis() - createdAt > 1000 * 60 * 60 * 24 * 7 // 7 days

    companion object {
        fun generateTokenValue() = UUID.randomUUID().toString()
    }
}
