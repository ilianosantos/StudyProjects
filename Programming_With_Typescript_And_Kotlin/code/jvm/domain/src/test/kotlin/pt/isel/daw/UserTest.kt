package pt.isel.daw

import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.assertEquals

class UserTest {
    @Test
    fun `test creating user successfully`() {
        val user =
            User(
                id = 1,
                name = "Anne",
                email = "anne@example.com",
                password = PasswordValidationInfo("6789012345")
            )
        assertEquals("Anne", user.name)
        assertEquals("anne@example.com", user.email)
    }
}