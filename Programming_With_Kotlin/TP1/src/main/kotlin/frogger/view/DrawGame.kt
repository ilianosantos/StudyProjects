package frogger.view
import frogger.domain.Coordinate
import pt.isel.canvas.Canvas
import frogger.domain.Frogger
import pt.isel.canvas.WHITE

const val CELL_SIZE = 48
const val SCREEN_WIDTH = CELL_SIZE * 14
const val SCREEN_HEIGHT = CELL_SIZE * 16
/** Only Demonstrative Code to draw lines for the grid

fun Canvas.drawGrid() {
    //DRAW HORIZONTAL LINES
    for (i in CELL_SIZE until height step CELL_SIZE)
        drawLine(0, i, width, i, WHITE, 1)
    //DRAW VERTICAL LINES
    for (i in 0 until width step CELL_SIZE)
        drawLine(i, 0, i, height, WHITE, 1)
}
*/
// Draws the elements of the game
fun Canvas.drawGame(game: Frogger) {
    erase()
    drawRect(0,0, width, height/2 + 6, 0x000070)
    //drawGrid()
    drawCar(Coordinate( 10, game.car4X), 37, CELL_SIZE)
    drawCar(Coordinate(13, game.car1X), 19, CELL_SIZE)
    drawGrass(CELL_SIZE/2)
    drawExtremityRoad(height / 2, CELL_SIZE)
    drawExtremityRoad(height - (CELL_SIZE * 2), CELL_SIZE)
}
//Draws the extremity of the Road
private fun Canvas.drawExtremityRoad(height: Int, cellSize: Int) {
    for (i in 0 until width step cellSize)
        drawImage("frogger|135,196,16,16", i, height, cellSize, cellSize)
}
// Draws the grass in the game
private fun Canvas.drawGrass(halfCell: Int) {
    val cellAndHalf = halfCell * 3
    val doubleCell = halfCell * 4
    val tripleCell = halfCell * 6
    for (i in 0 until width step tripleCell){
            drawImage("frogger|1,188,32,24", i, cellAndHalf, doubleCell, cellAndHalf)
            drawImage("frogger|35,188,8,24", i + doubleCell, cellAndHalf, halfCell, cellAndHalf)
            drawImage("frogger|35,188,8,24", i + doubleCell + halfCell, cellAndHalf, halfCell, cellAndHalf)
    }
}
// Draws the two cars in the game with the corresponded velocity
private fun Canvas.drawCar(cord: Coordinate, spriteX: Int, cellSize: Int) =
    drawImage("frogger|$spriteX,116,16,16", cord.column, cord.row * cellSize, cellSize, cellSize)
