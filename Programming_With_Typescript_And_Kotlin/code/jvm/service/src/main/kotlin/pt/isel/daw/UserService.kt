package pt.isel.daw

import jakarta.inject.Named

const val MAX_USER_TOKENS = 4

sealed class UserError {
    data object UserNotFound : UserError()
    data object UserAlreadyExists : UserError()
    data object EmailAlreadyInUse : UserError()
    data object PasswordTooWeak : UserError()
    data object InvalidEmail : UserError()
    data object NeedNotNullParameters : UserError()
    data object InvalidCredentials : UserError()
    data object NotLoggedIn : UserError()
    data object FailedToCreateToken : UserError()
    data object TokenNotFound : UserError()
    data object TokenExpired : UserError()
}

@Named
class UserService(
    private val trxManager: TransactionManager,
) {
    /**
     * Logs in a user with the given name and password
     * @return a token if the login was successful, or an error: InvalidCredentials, FailedToCreateToken
     */
    fun login(username: String, password: String): Either<UserError, TokenValidationInfo> =
        if (username.isBlank() || password.isBlank()) failure(UserError.InvalidCredentials)
        else trxManager.run {
            val user = repoUsers.findByUsername(username) ?: return@run failure(UserError.InvalidCredentials)
            val hashedPassword = HashEncoder.hash(password)
            if (user.password.validationInfo != hashedPassword) return@run failure(UserError.InvalidCredentials)
            checkUserTokens(user, MAX_USER_TOKENS - 1) // Check tokens expiration and gives space for the new token if needed
            val time = System.currentTimeMillis()
            val token = Token(TokenValidationInfo(Token.generateTokenValue()), time, time, user)
            if (!repoUsers.createToken(token)) failure(UserError.FailedToCreateToken)
            else success(token.token)
        }

    /**
     * Checks the user tokens: Deletes expired tokens and if the user has more than maxTokens, deletes the oldest ones
     * @param user the user to check the tokens
     * @param maxTokens the maximum number of tokens the user can have
     */
    fun checkUserTokens(user: User, maxTokens: Int) =
        trxManager.run {
            val tokens = repoUsers.getAllUserTokens(user)
            val filteredTokens = tokens.filter { !it.isExpired() }
            tokens.forEach { if (!filteredTokens.contains(it)) repoUsers.removeTokenByValidationInfo(it.token) }
            if (filteredTokens.size > maxTokens) {
                val sortedTokens = filteredTokens.sortedBy { it.createdAt }
                val tokensToDelete = sortedTokens.subList(0, filteredTokens.size - maxTokens)
                tokensToDelete.forEach { repoUsers.removeTokenByValidationInfo(it.token) }
            }
        }

    /**
     * Logs out a user with the given token (Deletes the token)
     * @return true if the logout was successful, or an error: NotLoggedIn
     */
    fun logout(token: TokenValidationInfo): Either<UserError, Boolean> = trxManager.run {
        repoUsers.getTokenByValidationInfo(token) ?: return@run failure(UserError.NotLoggedIn)
        repoUsers.removeTokenByValidationInfo(token)
        return@run success(true)
    }

    /**
     * Gets a user by its id
     * @return the user with the given id or an error: UserNotFound
     */
    fun getUserById(id: Int): Either<UserError, User> = trxManager.run {
        val user = repoUsers.findById(id) ?: return@run failure(UserError.UserNotFound)
        success(user)
    }

    /**
     * Gets a user by its name
     * @return the user with the given name or an error: UserNotFound
     */
    fun getUserByEmail(name: String): Either<UserError, User> = trxManager.run {
        val user = repoUsers.findByEmail(name) ?: return@run failure(UserError.UserNotFound)
        success(user)
    }

    /**
     * Creates a new user with the given fields
     * @return the created user or an error: NeedNotNullParameters, PasswordTooWeak, InvalidEmail, UserAlreadyExists, EmailAlreadyInUse
     */
    fun createUser(name: String, email: String, password: String): Either<UserError, User> = trxManager.run {
        if (name.isBlank() || email.isBlank() || password.isBlank()) return@run failure(UserError.NeedNotNullParameters)
        if (!User.validatePassword(password)) return@run failure(UserError.PasswordTooWeak)
        if (!User.validateEmail(email)) return@run failure(UserError.InvalidEmail)
        if (repoUsers.findByUsername(name) != null) return@run failure(UserError.UserAlreadyExists)
        if (repoUsers.findByEmail(email) != null) return@run failure(UserError.EmailAlreadyInUse)
        success(repoUsers.createUser(name, email, PasswordValidationInfo(HashEncoder.hash(password))))
    }

    /**
     * Updates the user with the given id
     * @return true if the user was updated or an error: UserNotFound, NeedNotNullParameters
     */
    fun updateUser(
        id: Int,
        newName: String? = null,
        newEmail: String? = null,
        newPassword: String? = null
    ): Either<UserError, Boolean> = trxManager.run {
        if (newName == null && newEmail == null && newPassword == null) // Need at least one parameter to update
            return@run failure(UserError.NeedNotNullParameters)

        val user = repoUsers.findById(id) ?: return@run failure(UserError.UserNotFound)

        val updatedUser = user.copy(
            name = newName ?: user.name,
            email = newEmail ?: user.email,
            password = PasswordValidationInfo(newPassword ?: user.password.validationInfo),
        )

        repoUsers.save(updatedUser)
        success(true)
    }

    /**
     * Deletes the user with the given id
     * @return true if the user was deleted or an error: UserNotFound
     */
    fun deleteUser(id: Int): Either<UserError, Boolean> = trxManager.run {
        if (repoUsers.findById(id) == null) return@run failure(UserError.UserNotFound)
        repoUsers.deleteById(id)
        success(true)
    }

    /**
     * Gets a token, if expired deletes it, otherwise gets the user and returns it
     * @return the user with the given token or an error: TokenNotFound, TokenExpired, UserNotFound
     */
    fun getUserByToken(tokenCode: String): Either<UserError, User> = trxManager.run {
        val token = repoUsers.getTokenByValidationInfo(TokenValidationInfo(tokenCode)) ?: return@run failure(UserError.TokenNotFound)
        if (token.isExpired()) {
            repoUsers.removeTokenByValidationInfo(token.token)
            return@run failure(UserError.TokenExpired)
        }
        val user = repoUsers.findById(token.user.id) ?: return@run failure(UserError.UserNotFound)
        success(user)
    }

    /**
     * Creates a new registration invite for the user with the given email and password
     * @return the new token
     */
    fun createRegistrationInvite(): Either<UserError, RegistrationInvite> = trxManager.run {
        val newInvite = RegistrationInvite.createInvite()
        repoUsers.createRegistrationInvite(newInvite)
        success(newInvite)
    }

    /**
     * Checks if the registration invite is valid
     * @return true if the invite is valid or false otherwise
     */
    fun isRegistrationInviteValid(code: String): Either<UserError, Boolean> = trxManager.run {
        success(repoUsers.getRegistrationInvite(code) != null)
    }

    /**
     * Deletes the registration invite
     * @return true if the invite was deleted or false otherwise
     */
    fun deleteRegistrationInvite(code: String): Either<UserError, Boolean> = trxManager.run {
        if (repoUsers.deleteRegistrationInvite(code)) success(true)
        else success(false)
    }
}
