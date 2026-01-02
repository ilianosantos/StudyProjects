package pt.isel.daw

import org.jdbi.v3.core.Handle
import java.sql.ResultSet
import java.sql.Timestamp

class RepositoryMessageJdbi(
    private val handle: Handle
) : MessageRepository {
    private val repoParticipants = RepositoryParticipantJdbi(handle)

    override fun createMessage(text: String, author: Participant): Message {
        val time = Timestamp(System.currentTimeMillis())
        val id = handle
            .createUpdate(
                """
            INSERT INTO MESSAGES (text, author_id, time)
            VALUES (:text, :author_id, :time)
            RETURNING id
            """,
            ).bind("text", text)
            .bind("author_id", author.id)
            .bind("time", time)
            .executeAndReturnGeneratedKeys()
            .mapTo(Int::class.java)
            .one()

        return Message(id, text, author, time)
    }

    override fun findByChannel(channelId: Int, skip: Int, max: Int): List<Message> {
        return handle
            .createQuery(
                """
            SELECT * FROM MESSAGES p WHERE author_id IN (
                SELECT id FROM PARTICIPANTS WHERE channel_id = :channelId
            )
            ORDER BY time DESC
            LIMIT :max OFFSET :skip
            """.trimIndent()
            )
            .bind("channelId", channelId)
            .bind("max", max)
            .bind("skip", skip)
            .map { rs, _ -> mapRowToMessage(rs) }
            .filterNotNull()
            .reversed()
    }

    override fun findAllByUser(authorId: Int): List<Message> {
        return handle
            .createQuery("SELECT * FROM MESSAGES WHERE author_id = :authorId")
            .bind("authorId", authorId)
            .map { rs, _ -> mapRowToMessage(rs) }
            .filterNotNull()
    }

    override fun findById(id: Int): Message? =
        handle
            .createQuery("SELECT * FROM MESSAGES WHERE id = :id")
            .bind("id", id)
            .map { rs, _ -> mapRowToMessage(rs) }
            .findOne()
            .orElse(null)

    override fun findAll(): List<Message> =
        handle
            .createQuery("SELECT * FROM MESSAGES")
            .map { rs, _ -> mapRowToMessage(rs) }
            .filterNotNull()

    override fun save(entity: Message) {

        handle
            .createUpdate(
                """
            UPDATE MESSAGES
            SET text = :text, author_id = :author_id, time = :time
            WHERE id = :id
            """,
            ).bind("text", entity.text)
            .bind("author_id", entity.author.id)
            .bind("time", entity.time)
            .bind("id", entity.id)
            .execute()
    }

    override fun deleteById(id: Int) {
        handle
            .createUpdate("DELETE FROM MESSAGES WHERE id = :id")
            .bind("id", id)
            .execute()
    }

    override fun clear() {
        handle
            .createUpdate("DELETE FROM MESSAGES")
            .execute()
    }
    private fun mapRowToMessage(rs: ResultSet): Message? {
        val owner = repoParticipants.findById(rs.getInt("author_id"))?: return null
        return Message(
            id = rs.getInt("id"),
            text = rs.getString("text"),
            author = owner,
            time = rs.getTimestamp("time")
        )
    }
}
