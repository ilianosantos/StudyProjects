package frogger.view

import frogger.domain.Direction
import frogger.domain.Frog
import frogger.domain.FrogState
import pt.isel.canvas.*

// Draws the frog in the game
fun Canvas.drawFrog(frog: Frog, cellSize: Int) {
    val spriteX = when (frog.dir) {
        Direction.UP -> 19
        Direction.DOWN -> 91
        Direction.LEFT -> 55
        Direction.RIGHT -> 127
    }
    val movement = when (frog.state) {
        FrogState.STAY, FrogState.HOME -> spriteX - DISTANCE
        FrogState.MOVE -> spriteX
        FrogState.SMASH_1 -> 1
        FrogState.SMASH_2 -> DISTANCE + 1
        FrogState.SMASH_3 -> DISTANCE * 2 + 1
        FrogState.DROWN_1 -> DISTANCE * 3 + 3
        FrogState.DROWN_2 -> DISTANCE * 4 + 2
        FrogState.DROWN_3 -> DISTANCE * 5 + 1
        FrogState.DEAD -> DISTANCE * 6
        FrogState.GONE -> DISTANCE * 7
    }
    val aliveFrog = if (frog.state == FrogState.STAY || frog.state == FrogState.MOVE) 0 else 80
    drawImage(
        "frogger|$movement,$aliveFrog,16,16",
        frog.position.x,
        frog.position.y,
        cellSize,
        cellSize
    )
}