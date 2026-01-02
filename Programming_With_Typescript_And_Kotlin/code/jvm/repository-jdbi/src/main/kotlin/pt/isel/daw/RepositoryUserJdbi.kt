package pt.isel.daw

import org.jdbi.v3.core.Handle
import org.jdbi.v3.core.mapper.RowMapper
import org.jdbi.v3.core.statement.StatementContext
import java.sql.ResultSet
import java.sql.Timestamp

class RepositoryUserJdbi(
    private val handle: Handle
) : UserRepository {
    override fun createUser(name: String, email: String, password: PasswordValidationInfo): User {
        val id = handle
            .createUpdate(
                    """
            INSERT INTO USERS (name, email, password_validation) 
            VALUES (:name, :email, :password_validation)
            RETURNING id
            """,
                ).bind("name", name)
                .bind("email", email)
                .bind("password_validation", password.validationInfo)
                .executeAndReturnGeneratedKeys()
                .mapTo(Int::class.java)
                .one()

        return User(id, name, email, password)
    }

    override fun findByUsername(username: String): User? =
        handle
            .createQuery("SELECT * FROM USERS WHERE name = :name")
            .bind("name", username)
            .map(UserMapper())
            .findOne()
            .orElse(null)

    override fun findByEmail(email: String): User? =
        handle
            .createQuery("SELECT * FROM USERS WHERE email = :email")
            .bind("email", email)
            .map(UserMapper())
            .findOne()
            .orElse(null)

    override fun findById(id: Int): User? =
        handle
            .createQuery("SELECT * FROM USERS WHERE id = :id")
            .bind("id", id)
            .map(UserMapper())
            .findOne()
            .orElse(null)

    override fun findAll(): List<User> =
        handle
            .createQuery("SELECT * FROM USERS")
            .map(UserMapper())
            .list()

    override fun save(entity: User) {
        handle
            .createUpdate(
                """
            UPDATE USERS 
            SET name = :name, email = :email, password_validation = :password_validation
            WHERE id = :id
            """,
            ).bind("name", entity.name)
            .bind("email", entity.email)
            .bind("password_validation", entity.password.validationInfo)
            .bind("id", entity.id)
            .execute()
    }

    override fun deleteById(id: Int) {
        handle
            .createUpdate("DELETE FROM USERS WHERE id = :id")
            .bind("id", id)
            .execute()
    }

    override fun clear() {
        handle.createUpdate("DELETE FROM TOKENS").execute()
        handle.createUpdate("DELETE FROM USERS").execute()
    }

    override fun getTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Token? =
        handle
            .createQuery(
                """
            SELECT u.id, u.name, u.email, u.password_validation, t.token, t.createdAt, t.lastUsedAt
            FROM USERS u
            JOIN TOKENS t ON u.id = t.user_id
            WHERE token = :token
            """,
            ).bind("token", tokenValidationInfo.validationInfo)
            .map { rs, _ ->
                TokenModel(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    PasswordValidationInfo(rs.getString("password_validation")),
                    TokenValidationInfo(rs.getString("token")),
                    rs.getTimestamp("createdAt"),
                    rs.getTimestamp("lastUsedAt")
                )
            }
            .singleOrNull()
            ?.tok

    override fun getAllUserTokens(user: User): List<Token> =
        handle
        .createQuery(
            """
            SELECT token, createdAt, lastUsedAt
            FROM TOKENS
            WHERE user_id = :user_id
            """
        ).bind("user_id", user.id)
        .map { rs, _ ->
            Token(
                TokenValidationInfo(rs.getString("token")),
                rs.getTimestamp("createdAt").time,
                rs.getTimestamp("lastUsedAt").time,
                user
            )
        }
        .list()


    override fun createToken(token: Token): Boolean {
        return try {
            val exec = handle
                .createUpdate(
                    """
                INSERT INTO TOKENS (token, createdAt, lastUsedAt, user_id)
                VALUES (:token, :createdAt, :lastUsedAt, :user_id)
            """
                )
                .bind("token", token.token.validationInfo)
                .bind("createdAt", Timestamp(token.createdAt))
                .bind("lastUsedAt", Timestamp(token.createdAt))
                .bind("user_id", token.user.id)
                .execute()
            exec == 1
        }catch (e: Exception){
            return false
        }

    }

        override fun removeTokenByValidationInfo(tokenValidationInfo: TokenValidationInfo): Boolean {
            return handle
                .createUpdate(
                    """
                DELETE FROM TOKENS
                WHERE token = :token
                """
                )
                .bind("token", tokenValidationInfo.validationInfo)
                .execute() == 1
        }

    override fun createRegistrationInvite(invite: RegistrationInvite): Boolean {
        return handle
            .createUpdate(
                """
            INSERT INTO REGISTRATION_INVITES (code)
            VALUES (:code)
            """
            )
            .bind("code", invite.code)
            .execute() == 1
    }

    override fun getRegistrationInvite(inviteCode: String): RegistrationInvite? {
        return handle
            .createQuery(
                """
            SELECT code
            FROM REGISTRATION_INVITES
            WHERE code = :code
            """
            )
            .bind("code", inviteCode)
            .map { rs, _ -> RegistrationInvite(rs.getString("code")) }
            .findOne()
            .orElse(null)
    }

    override fun deleteRegistrationInvite(inviteCode: String): Boolean {
        return handle
            .createUpdate(
                """
            DELETE FROM REGISTRATION_INVITES
            WHERE code = :code
            """
            )
            .bind("code", inviteCode)
            .execute() == 1
    }


    private class UserMapper : RowMapper<User> {
            override fun map(
                rs: ResultSet,
                ctx: StatementContext,
            ): User =
                User(
                    id = rs.getInt("id"),
                    name = rs.getString("name"),
                    email = rs.getString("email"),
                    password = PasswordValidationInfo(rs.getString("password_validation")),
                )
        }

        private data class TokenModel(
            val id: Int,
            val name: String,
            val email: String,
            val passwordValidation: PasswordValidationInfo,
            val tokenValidation: TokenValidationInfo,
            val createdAt: Timestamp,
            val lastUsedAt: Timestamp
        ) {
            val tok: Token
                get() =
                    Token(
                        tokenValidation,
                        createdAt.time,
                        lastUsedAt.time,
                        User(id, name, email, passwordValidation)
                    )
        }
}