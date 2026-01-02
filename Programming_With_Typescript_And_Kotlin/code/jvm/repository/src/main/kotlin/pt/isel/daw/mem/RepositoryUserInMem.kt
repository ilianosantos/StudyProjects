package pt.isel.daw.mem

import pt.isel.daw.*


class RepositoryUserInMem : UserRepository {
    val registrationInvites = mutableListOf<RegistrationInvite>()
    val users = mutableListOf<User>()
    val tokens = mutableListOf<Token>()

    override fun createUser(name: String, email: String, password: PasswordValidationInfo): User =
        User(users.size, name = name, email = email, password = password)
            .also { users.add(it) }

    override fun findByUsername(username: String): User? =
        users.firstOrNull { it.name == username }

    override fun findByEmail(email: String): User? =
        users.firstOrNull { it.email == email }

    override fun findById(id: Int): User? =
        users.firstOrNull { it.id == id }

    override fun findAll(): List<User> =
        users.toList()

    override fun save(entity: User) {
        users.removeIf { it.id == entity.id }
        users.add(entity)
    }

    override fun deleteById(id: Int) {
        users.removeIf { it.id == id }
    }

    override fun clear(): Unit = users.clear()

    override fun createToken(token: Token): Boolean {
        if (tokens.any { it.token.validationInfo == token.token.validationInfo }) return false
        return tokens.add(token)
    }

    override fun getTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Token? =
        tokens.firstOrNull { it.token.validationInfo == tokenValidationInfo.validationInfo }

    override fun getAllUserTokens(user: User): List<Token> = tokens.filter { it.user == user }

    override fun removeTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Boolean {
        val token = tokens.firstOrNull { it.token.validationInfo == tokenValidationInfo.validationInfo }
        return if (token != null) {
            tokens.remove(token)
            true
        }
        else false
    }

    override fun createRegistrationInvite(invite: RegistrationInvite): Boolean =
        registrationInvites.add(invite)

    override fun getRegistrationInvite(inviteCode: String): RegistrationInvite? =
        registrationInvites.firstOrNull { it.code == inviteCode }

    override fun deleteRegistrationInvite(inviteCode: String): Boolean =
        registrationInvites.removeIf { it.code == inviteCode }
}
