package frogger.view

import frogger.domain.Car
import pt.isel.canvas.*

// Draws the cars in the game with the corresponded spriteX
fun Canvas.drawCar(cars: List<Car>, spriteXlist: List<Int>, cellSize: Int) =
    cars.forEach {
        drawImage(
            "frogger|${spriteXlist[it.type.ordinal]},116,${16 * it.type.size},16",
            it.part.x,
            it.part.row * cellSize,
            cellSize * it.type.size,
            cellSize
        )
    }