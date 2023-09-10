package frogger.view

import frogger.domain.Turtle
import frogger.domain.TurtleState
import frogger.domain.state
import pt.isel.canvas.Canvas

// Draws the turtles in the game
fun Canvas.drawTurtle(turtles: List<Turtle>, gridSize: Int) =
    turtles.forEach {
        val spriteX = when(it.state()){
            TurtleState.SWIM_1 -> DISTANCE*0
            TurtleState.SWIM_2 -> DISTANCE*1
            TurtleState.SWIM_3 -> DISTANCE*2
            TurtleState.DIVE_1 -> DISTANCE*3
            TurtleState.DIVE_2 -> DISTANCE*4
            TurtleState.UNDER_WATER -> DISTANCE*7
        }
        for (i in 0 until it.part.size)
            drawImage(
                "frogger|$spriteX,152,16,16",
                it.part.x + i * gridSize,
                it.part.row * gridSize,
                gridSize,
                gridSize
            )
    }