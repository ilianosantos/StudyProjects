package pt.isel.daw

interface ParticipantRepository: Repository<Participant> {
    fun createParticipant(
        user: User,
        channel: Channel,
        type: ParticipantKind
    ): Participant

    fun findAllByChannel(channelId: Int): List<Participant>

    fun findAllByUserId(userId: Int): List<Participant>

    fun findByChannelAndId(
        channelId: Int,
        userId: Int
    ): Participant?

    fun deleteByChannelAndId(
        channelId: Int,
        userId: Int
    ): Boolean
}