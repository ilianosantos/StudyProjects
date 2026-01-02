package pt.isel.daw

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.*
import pt.isel.daw.fakes.member
import pt.isel.daw.fakes.part

class MessageTest {
    @Test
    fun `test creating message with no text`() {
        val exception = assertThrows<IllegalArgumentException> {
            Message(
                id = 1,
                text = "",
                author = part
            )
        }
        assertEquals("Text must not be blank", exception.message)
    }
}