package frogger

import frogger.domain.CAR1_START_X
import frogger.domain.CAR4_START_X
import frogger.domain.Frogger
import frogger.domain.step
import frogger.view.SCREEN_HEIGHT
import frogger.view.SCREEN_WIDTH
import frogger.view.drawGame
import pt.isel.canvas.BLACK
import pt.isel.canvas.Canvas
import pt.isel.canvas.onFinish
import pt.isel.canvas.onStart

const val REFRESH_TIME = 25 // 40 fps (1000/40 = 25 ms)
fun main() {
    onStart {
        val canvas = Canvas(SCREEN_WIDTH, SCREEN_HEIGHT, BLACK)
        var game = Frogger(car1X= CAR1_START_X, car4X= CAR4_START_X)
        canvas.onTimeProgress(REFRESH_TIME) {
            game = game.step()
            canvas.drawGame(game)
        }
        canvas.onKeyPressed { key ->
            when (key.char) {
                '1' -> game = game.copy(car1X= CAR1_START_X)
                '4' -> game = game.copy(car4X= CAR4_START_X)
                'q','Q' -> canvas.close()
            }
        }
    }
    onFinish { }
}
