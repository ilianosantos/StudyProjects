package pt.isel.daw

interface ChannelRepository: Repository<Channel> {
    fun createChannel(
        name: String,
        owner: User,
        type: ChannelKind = ChannelKind.PUBLIC,
        inviteCodeReadOnly: String? = null,
        inviteCodeWithWrite: String? = null
    ): Channel
    fun findByName(name: String): Channel?
    fun findByInvite(code: String): Channel?
    fun findAllPublic() : List<Channel>
}
