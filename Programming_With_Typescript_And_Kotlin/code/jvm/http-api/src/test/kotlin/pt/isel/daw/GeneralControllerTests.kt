package pt.isel.daw

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import pt.isel.daw.controllers.GeneralController

class GeneralControllerTests {
    private val generalController = GeneralController()

    @Test
    fun `test index`() {
        val result = generalController.index()

        assertTrue(result.isNotBlank()) {
            "Expected non-blank response but got an empty string"
        }
    }
}
