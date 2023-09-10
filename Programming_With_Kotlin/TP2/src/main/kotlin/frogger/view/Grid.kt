
package frogger.view
import frogger.domain.*
import pt.isel.canvas.*

const val SCREEN_WIDTH = GRID_SIZE * 14
const val SCREEN_HEIGHT = GRID_SIZE * 16
private const val DISTANCE = 18
private const val DARK_BLUE = 0x000070
// Draws the elements of the game
fun Canvas.drawGame(game: Frogger) {
    erase()
    drawRect(0,0, width, height/2 + 6, DARK_BLUE)
    drawGrass(GRID_SIZE/2)
    drawExtremityRoad(height / 2, GRID_SIZE)
    drawExtremityRoad(height - GRID_SIZE * 2, GRID_SIZE)
    drawCar(game.cars, listOf(74, 37, 1, 56, 19), GRID_SIZE)
    drawFrog(game.frog, GRID_SIZE)
    if (game.frog.state == FrogState.GONE)
        drawGameOver(
            SCREEN_WIDTH / 6, SCREEN_HEIGHT / 2, GRID_SIZE,
            listOf(
                "145,361", "91,361", "46,370", "127,361",
                "46,379", "64,370", "127,370", "127,361", "91,370"
            )
        )
    drawGrid()
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
// Draws the cars in the game with the corresponded spriteX
private fun Canvas.drawCar(cars: List<Car>, spriteXlist:List<Int>, cellSize: Int) {
    cars.forEach {
        drawImage(
            "frogger|${spriteXlist[it.type.ordinal]},116,${16*it.type.size},16",
            it.part.x,
            it.part.row * cellSize,
            cellSize*it.type.size,
            cellSize
        )
    }
}
// Draws the frog in the game

private fun Canvas.drawFrog(frog: Frog, cellSize: Int){
    val spriteX = when(frog.dir){
        Direction.UP -> 19
        Direction.DOWN -> 91
        Direction.LEFT -> 55
        Direction.RIGHT -> 127
    }
    val movement = when(frog.state){
        FrogState.STAY, FrogState.HOME -> spriteX - DISTANCE
        FrogState.MOVE -> spriteX
        FrogState.SMASH_1 -> 1
        FrogState.SMASH_2 -> DISTANCE+1
        FrogState.SMASH_3 -> DISTANCE*2+1
        FrogState.DROWN_1 -> DISTANCE*3+3
        FrogState.DROWN_2 -> DISTANCE*4+2
        FrogState.DROWN_3 -> DISTANCE*5+1
        FrogState.DEAD -> DISTANCE*6
        FrogState.GONE -> DISTANCE*7
    }
    val aliveFrog = if (frog.state== FrogState.STAY || frog.state== FrogState.MOVE) 0 else 80
    drawImage("frogger|$movement,$aliveFrog,16,16",
        frog.position.x,
        frog.position.y,
        cellSize,
        cellSize
    )
}
// Game Over in the end of the game, above -> GA-E---E- and under -> --M-(space)OV-R
fun Canvas.drawGameOver(iX: Int, iY: Int, cell: Int, list: List<String>) =
    list.map({
        it.first() .. 'z'
    }
    )

fun Canvas.drawGrid() {
    //DRAW HORIZONTAL LINES
    for (i in GRID_SIZE until height step GRID_SIZE)
        drawLine(0, i, width, i, WHITE, 1)
    //DRAW VERTICAL LINES
    for (i in 0 until width step GRID_SIZE)
        drawLine(i, 0, i, height, WHITE, 1)
}
