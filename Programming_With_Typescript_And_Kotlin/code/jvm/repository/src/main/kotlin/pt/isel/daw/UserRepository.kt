package pt.isel.daw

interface UserRepository: Repository<User> {
    fun createUser(name: String, email: String, password: PasswordValidationInfo): User

    fun findByUsername(username: String): User?

    fun findByEmail(email: String): User?

    fun createToken(token: Token): Boolean

    fun getTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Token?

    fun getAllUserTokens(user: User): List<Token>

    fun removeTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Boolean

    fun createRegistrationInvite(invite: RegistrationInvite): Boolean

    fun getRegistrationInvite(inviteCode: String): RegistrationInvite?

    fun deleteRegistrationInvite(inviteCode: String): Boolean
}
