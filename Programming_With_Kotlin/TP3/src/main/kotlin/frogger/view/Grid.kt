
package frogger.view
import frogger.domain.*
import pt.isel.canvas.*

const val SCREEN_WIDTH = GRID_SIZE * 14
const val SCREEN_HEIGHT = GRID_SIZE * 16
const val DISTANCE = 18
private const val DARK_BLUE = 0x000070
private const val SCALE_TO_RECT = 6

fun Canvas.drawGame(game: Frogger) {
    erase()
    drawRect(0,0, width, height/2 + SCALE_TO_RECT, DARK_BLUE)
    drawGrass(GRID_SIZE/2)
    drawExtremityRoad(height / 2, GRID_SIZE)
    drawExtremityRoad(height - GRID_SIZE * 2, GRID_SIZE)
    drawCar(game.cars, listOf(74, 37, 1, 56, 19), GRID_SIZE)
    drawLog(game.logs, GRID_SIZE, listOf(4, 19, 37))
    drawTurtle(game.turtles, GRID_SIZE)
    drawFrog(game.frog, GRID_SIZE)
    if(game.homes.any())
        drawHome(game.homes, GRID_SIZE)
    if (game.over) {
        if (game.homes.all { it.isFull() })
            drawYouWin(SCREEN_WIDTH / 6, SCREEN_HEIGHT / 2, GRID_SIZE,
                listOf(
                    "1,379", "64,370", "117,370", "46,379", "135,370", "10,370","55,370"
                ))
        else
            drawGameOver(SCREEN_WIDTH / 6, SCREEN_HEIGHT / 2, GRID_SIZE,
                listOf(
                    "145,361", "91,361", "46,370", "127,361", "46,379", "64,370", "127,370", "127,361", "91,370"
                )
            )
    }
    //drawGrid()
}
//Draws the extremity of the Road
private fun Canvas.drawExtremityRoad(height: Int, gridSize: Int) {
    for (i in 0 until width step gridSize)
        drawImage("frogger|135,196,16,16", i, height, gridSize, gridSize)
}
// Draws the grass in the game
private fun Canvas.drawGrass(halfCell: Int) {
    val cellAndHalf = halfCell * 3
    val doubleCell = halfCell * 4
    val tripleCell = halfCell * 6
    for (i in 0 until width step tripleCell) {
        drawImage("frogger|1,188,32,24", i, cellAndHalf, doubleCell, cellAndHalf)
        drawImage("frogger|35,188,8,24", i + doubleCell, cellAndHalf, halfCell, cellAndHalf)
        drawImage("frogger|35,188,8,24", i + doubleCell + halfCell, cellAndHalf, halfCell, cellAndHalf)
    }
}
// Draws the homes in the game
private fun Canvas.drawHome(homes: List<Home>, gridSize: Int) =
    homes.forEach {if (it.isFull())
        drawImage("frogger|45,196,16,16", it.x,gridSize * 2, gridSize, gridSize)
    }
// Game Over in the end of the game, first line -> GA-E---E- , second line -> --M--OV-R , third line -> Y--(space)---
private fun Canvas.drawGameOver(iX: Int, iY: Int, cell: Int, list: List<String>) =
    list.forEachIndexed { idx, elem ->
        drawImage("frogger|$elem,9,9", iX + idx * cell, iY, cell, cell)
    }
// You Win in the end of the game, second line -> -OU-WIN , third line -> Y--(space)---
private fun Canvas.drawYouWin(iX: Int, iY: Int, cell: Int, list: List<String>) =
    list.forEachIndexed { idx, elem ->
        drawImage("frogger|$elem,9,9", iX + idx * cell, iY, cell, cell)
    }
/*
private fun Canvas.drawGrid() {
    //DRAW HORIZONTAL LINES
    for (i in GRID_SIZE until height step GRID_SIZE)
        drawLine(0, i, width, i, WHITE, 1)
    //DRAW VERTICAL LINES
    for (i in 0 until width step GRID_SIZE)
        drawLine(i, 0, i, height, WHITE, 1)
}
 */