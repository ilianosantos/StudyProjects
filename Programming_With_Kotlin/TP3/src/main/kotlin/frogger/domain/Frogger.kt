package frogger.domain

/**
 * Represents the state of the game.
 * @property frog the frog representation
 * @property cars the list of cars in the game
 */
data class Frogger(
    val frog: Frog, val cars: List<Car>, val over: Boolean = false, // 2.º trabalho
    val logs: List<Log>,
    val turtles: List<Turtle>,
    val homes: List<Home>,
// Propriedades para as funcionalidades opcionais...
)
