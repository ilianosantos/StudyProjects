package pt.isel.daw

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import pt.isel.daw.fakes.member
import pt.isel.daw.fakes.message
import pt.isel.daw.fakes.owner

class ChannelTest {
    @Test
    fun `test creating channel successfully`() {
        val channel =
            Channel(
                id = 1,
                name = "General",
                owner = owner,
                type = ChannelKind.PUBLIC,
                inviteCodeWithWrite = null,
                inviteCodeReadOnly = null
            )
        assertEquals("General", channel.name)
        assertEquals(ChannelKind.PUBLIC, channel.type)
    }

    @Test
    fun `test creating channel with no name`() {
        val exception = assertThrows<IllegalArgumentException> {
            Channel(
                id = 1,
                name = "",
                owner = owner,
                type = ChannelKind.PUBLIC,
                inviteCodeWithWrite = null,
                inviteCodeReadOnly = null
            )
        }
        assertEquals("Name must not be blank", exception.message)
    }
}