package frogger

import pt.isel.canvas.*
import frogger.domain.*
import frogger.view.SCREEN_HEIGHT
import frogger.view.SCREEN_WIDTH
import frogger.view.drawGame
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.withLock

const val REFRESH_TIME = 25  // 40 fps  (1000/40 = 25 ms)

/**
 * The main function of the domain.Frogger game.
 * Creates a canvas and starts the game.
 * The frog is moved by pressing the arrow keys.
 * The game evolved and is redrawn every REFRESH TIME.
 */
fun main() {
    onStart {
        val canvas = Canvas(SCREEN_WIDTH, SCREEN_HEIGHT, BLACK)
        var game = Frogger(frog= createFrog(), cars= createCars(),
            logs = createLogs(), turtles = createTurtles(),
            homes = createHomes()
        )
        canvas.onKeyPressed { key ->
            val dir = key.toDirection()
            if (dir != null) game = game.moveFrog(dir)
        }
        canvas.onTimeProgress(REFRESH_TIME) {
            game = game.step()
            canvas.drawGame(game)
        }
    }
    onFinish { }
}

/**
 * Returns the direction corresponding to the pressed key.
 * If key is not a direction key, returns null.
 * @receiver the event of key pressed
 * @return the direction corresponding to the key pressed or null
 */
fun KeyEvent.toDirection(): Direction? = when(code) {
    LEFT_CODE -> Direction.LEFT
    RIGHT_CODE -> Direction.RIGHT
    UP_CODE -> Direction.UP
    DOWN_CODE -> Direction.DOWN
    else -> null
}
