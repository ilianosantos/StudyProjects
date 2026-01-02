package pt.isel.daw.mem

import pt.isel.daw.*


class RepositoryParticipantInMem: ParticipantRepository {
    val participants = mutableListOf<Participant>()

    override fun createParticipant(
        user: User,
        channel: Channel,
        type: ParticipantKind
    ): Participant {
        val participant = Participant(participants.size, user, channel, type)
        participants.add(participant)
        return participant
    }

    override fun findAllByChannel(channelId: Int): List<Participant> =
        participants.filter { it.channel.id == channelId }

    override fun findAllByUserId(userId: Int): List<Participant> =
        participants.filter { it.user.id == userId }

    override fun findById(id: Int): Participant? = participants.firstOrNull { it.id == id }

    override fun findAll(): List<Participant> = participants.toList()

    override fun findByChannelAndId(channelId: Int, userId: Int): Participant? =
        participants.firstOrNull { it.channel.id == channelId && it.user.id == userId }

    override fun deleteByChannelAndId(channelId: Int, userId: Int): Boolean {
        val participant = findByChannelAndId(channelId, userId)
        return if (participant != null) participants.remove(participant) else false
    }

    override fun save(entity: Participant) {
        participants.removeIf { it.id == entity.id }
        participants.add(entity)
    }

    override fun deleteById(id: Int) {
        participants.removeIf { it.id == id }
    }

    override fun clear() {
        participants.clear()
    }
}