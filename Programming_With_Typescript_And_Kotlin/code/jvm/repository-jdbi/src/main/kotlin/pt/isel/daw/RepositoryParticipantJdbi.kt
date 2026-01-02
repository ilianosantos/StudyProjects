package pt.isel.daw

import org.jdbi.v3.core.Handle
import java.sql.ResultSet

class RepositoryParticipantJdbi(
    private val handle: Handle
): ParticipantRepository {
    private val repoChannels get() = RepositoryChannelJdbi(handle)
    private val repoUsers get() = RepositoryUserJdbi(handle)

    override fun createParticipant(user: User, channel: Channel, type: ParticipantKind): Participant {
        val id = handle
            .createUpdate(
                """
            INSERT INTO PARTICIPANTS (user_id, channel_id, type) 
            VALUES (:user_id, :channel_id, :type)
            RETURNING id
            """,
            ).bind("user_id", user.id)
            .bind("channel_id", channel.id)
            .bind("type", type.toString())
            .executeAndReturnGeneratedKeys()
            .mapTo(Int::class.java)
            .one()
        return Participant(id, user, channel, type)
    }

    override fun findAllByChannel(channelId: Int): List<Participant> {
        return handle
            .createQuery(
                """
            SELECT * FROM PARTICIPANTS 
            WHERE channel_id = :channel_id
            """,
            ).bind("channel_id", channelId)
            .map { rs, _ -> mapRowToParticipant(rs) }
            .filterNotNull()
    }

    override fun findAllByUserId(userId: Int): List<Participant> {
        return handle
            .createQuery(
                """
            SELECT * FROM PARTICIPANTS 
            WHERE user_id = :user_id
            """,
            ).bind("user_id", userId)
            .map { rs, _ -> mapRowToParticipant(rs) }
            .filterNotNull()
    }

    override fun findByChannelAndId(channelId: Int, userId: Int): Participant? =
        handle
            .createQuery(
                """
            SELECT * FROM PARTICIPANTS 
            WHERE channel_id = :channel_id AND user_id = :user_id
            """,
            ).bind("channel_id", channelId)
            .bind("user_id", userId)
            .map { rs, _ -> mapRowToParticipant(rs) }
            .findOne()
            .orElse(null)

    override fun deleteByChannelAndId(channelId: Int, userId: Int): Boolean =
        handle
            .createUpdate(
                """
            DELETE FROM PARTICIPANTS 
            WHERE channel_id = :channel_id AND user_id = :user_id
            """,
            ).bind("channel_id", channelId)
            .bind("user_id", userId)
            .execute() > 0

    override fun findById(id: Int): Participant? {
        return handle
            .createQuery(
                """
            SELECT * FROM PARTICIPANTS 
            WHERE id = :id
            """,
            ).bind("id", id)
            .map { rs, _ -> mapRowToParticipant(rs) }
            .findOne()
            .orElse(null)
    }

    override fun findAll(): List<Participant> {
        return handle
            .createQuery(
                """
            SELECT * FROM PARTICIPANTS
            """
            ).map { rs, _ -> mapRowToParticipant(rs) }
            .filterNotNull()
    }

    override fun save(entity: Participant) {
        handle
            .createUpdate(
                """
            UPDATE PARTICIPANTS 
            SET user_id = :user_id, channel_id = :channel_id, type = :type
            WHERE id = :id
            """,
            ).bind("user_id", entity.user.id)
            .bind("channel_id", entity.channel.id)
            .bind("type", entity.type.toString())
            .bind("id", entity.id)
            .execute()
    }

    override fun deleteById(id: Int) {
        handle
            .createUpdate(
                """
            DELETE FROM PARTICIPANTS 
            WHERE id = :id
            """,
            ).bind("id", id)
            .execute()
    }

    override fun clear() {
        handle
            .createUpdate(
                """
            DELETE FROM PARTICIPANTS
            """
            ).execute()
    }

    private fun mapRowToParticipant(rs: ResultSet): Participant? {
        val channel = repoChannels.findById(rs.getInt("channel_id"))
        val user = repoUsers.findById(rs.getInt("user_id"))

        if (channel == null || user == null)
            return null

        return Participant(
            id = rs.getInt("id"),
            user = user,
            channel = channel,
            type = ParticipantKind.valueOf(rs.getString("type"))
        )
    }
}