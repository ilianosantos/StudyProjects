package pt.isel.daw

import java.util.*

data class RegistrationInvite (
    val code: String
) {
    companion object {
        private fun generateCode() : String = UUID.randomUUID().toString()

        fun createInvite() : RegistrationInvite = RegistrationInvite(generateCode())
    }
}
