package pt.isel.daw

import org.jdbi.v3.core.Handle
import java.sql.ResultSet

class RepositoryChannelJdbi(
    private val handle: Handle
) : ChannelRepository {
    private val repoUsers get() = RepositoryUserJdbi(handle)

    override fun createChannel(
        name: String,
        owner: User,
        type: ChannelKind,
        inviteCodeReadOnly: String?,
        inviteCodeWithWrite: String?
    ): Channel {
        val id = handle
            .createUpdate(
                """
            INSERT INTO CHANNELS (name, owner_id, type, invite_code_with_write, invite_code_read_only) 
            VALUES (:name, :owner_id, :type, :invite_code_with_write, :invite_code_read_only)
            RETURNING id
            """,
            ).bind("name", name)
            .bind("type", type)
            .bind("owner_id", owner.id)
            .bind("invite_code_with_write", inviteCodeWithWrite)
            .bind("invite_code_read_only", inviteCodeReadOnly)
            .executeAndReturnGeneratedKeys()
            .mapTo(Int::class.java)
            .one()

        return Channel(id, name, owner, type, inviteCodeWithWrite, inviteCodeReadOnly)
    }

    override fun findByName(name: String): Channel? =
        handle
            .createQuery("""
            SELECT * FROM CHANNELS c
            WHERE name = :name
            """
            ).bind("name", name)
            .map { rs, _ -> mapRowToChannel(rs) }
            .findOne()
            .orElse(null)

    override fun findByInvite(code: String): Channel? =
        handle
            .createQuery("""
            SELECT * FROM CHANNELS c
            WHERE invite_code_with_write = :code OR invite_code_read_only = :code
            """
            ).bind("code", code)
            .map { rs, _ -> mapRowToChannel(rs) }
            .findOne()
            .orElse(null)

    override fun findAllPublic(): List<Channel> {
        return handle
            .createQuery("""
                SELECT * FROM CHANNELS c
                WHERE type = :type
            """
            ).bind("type", ChannelKind.PUBLIC)
            .map { rs, _ -> mapRowToChannel(rs) }
            .filterNotNull()
    }

    override fun findById(id: Int): Channel? =
        handle
            .createQuery("""
            SELECT * FROM CHANNELS c
            WHERE c.id = :id
            """
            ).bind("id", id)
            .map { rs, _ -> mapRowToChannel(rs) }
            .findOne()
            .orElse(null)

    override fun findAll(): List<Channel> =
        handle
            .createQuery("""
                SELECT * FROM CHANNELS c
            """
            )
            .map { rs, _ -> mapRowToChannel(rs) }
            .filterNotNull()

    override fun save(entity: Channel) {
        handle
            .createUpdate(
                """
            UPDATE CHANNELS 
            SET name = :name, type = :type, owner_id = :owner_id, invite_code_with_write = :invite_code_with_write, invite_code_read_only = :invite_code_read_only
            WHERE id = :id
            """,
            ).bind("id", entity.id)
            .bind("name", entity.name)
            .bind("type", entity.type)
            .bind("owner_id", entity.owner.id)
            .bind("invite_code_with_write", entity.inviteCodeWithWrite)
            .bind("invite_code_read_only", entity.inviteCodeReadOnly)
            .execute()
    }

    override fun deleteById(id: Int) {
        handle
            .createUpdate("DELETE FROM CHANNELS WHERE id = :id")
            .bind("id", id)
            .execute()
    }

    override fun clear() {
        handle.createUpdate("DELETE FROM CHANNELS").execute()
    }

    private fun mapRowToChannel(rs: ResultSet): Channel? {
        val user = repoUsers.findById(rs.getInt("owner_id"))?: return null
        return Channel(
            id = rs.getInt("id"),
            name = rs.getString("name"),
            owner = user,
            type = ChannelKind.valueOf(rs.getString("type")),
            inviteCodeWithWrite = rs.getString("invite_code_with_write"),
            inviteCodeReadOnly = rs.getString("invite_code_read_only")
        )
    }
}
