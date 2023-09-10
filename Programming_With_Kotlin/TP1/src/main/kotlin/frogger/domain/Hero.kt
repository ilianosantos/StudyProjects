package frogger.domain

import frogger.view.CELL_SIZE
import frogger.view.SCREEN_WIDTH

const val CAR1_START_X = SCREEN_WIDTH - CELL_SIZE
const val CAR4_START_X = 0

data class Frogger (val car1X:Int, val car4X: Int)
//This function represents the movement for the two cars that appear in the game
fun Frogger.step(): Frogger {
    val resetCar1 = SCREEN_WIDTH
    val resetCar4 = -CELL_SIZE
    if(car1X<resetCar4) return copy(car1X = resetCar1)
    if (car4X>SCREEN_WIDTH) return copy(car4X = resetCar4)
    //We created a scale to represent the difference in the velocity of the cars.
    val scale = 1
    return copy(car1X = car1X - scale, car4X = car4X + scale*4)
}
