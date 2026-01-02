package pt.isel.daw

data class User (
    val id: Int,
    val name: String,
    val email: String,
    val password: PasswordValidationInfo,
) {
    companion object {
        fun validatePassword(password: String): Boolean {
            val hasUpperCase = password.matches(Regex(".*[A-Z].*")) // at least one uppercase
            val hasLowerCase = password.matches(Regex(".*[a-z].*")) // at least one lowercase
            val hasDigit = password.matches(Regex(".*\\d.*")) // at least one digit
            val hasSpecialChar = password.matches(Regex(".*[!@#\$%^&*()-+].*")) // at least one special character
            val hasLength = password.length in 8..64 // at least 8 characters and at most 64
            return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar && hasLength
        }

        fun validateEmail(email: String): Boolean =
            email.matches(Regex("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}")) // email format
    }

    override fun toString(): String =
        "User(id=$id, name='$name', email='$email', password='$password')"
}
