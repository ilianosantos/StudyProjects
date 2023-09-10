package frogger.domain

import frogger.move
import frogger.toRangeX
import frogger.view.SCREEN_HEIGHT
import frogger.view.SCREEN_WIDTH

/**
 * Represents the state of a frog.
 * STAY, GONE and HOME are stable states, the others are intermediate states.
 * When frog is moved: STAY => MOVE->(STAY|HOME).
 * When frog is smashed: (STAY||MOVE) => SMASH_1->SMASH_2->SMASH_3->DEAD->GONE.
 * When frog is drowned: (STAY||MOVE) => DROWN_1->DROWN_2->DROWN_3->DEAD->GONE.
 */
enum class FrogState {
    STAY,   // Frog is not moving (in a cell)
    MOVE,   // Frog is moving between cells
    SMASH_1, SMASH_2, SMASH_3,  // Intermediate states when frog is smashed
    DROWN_1, DROWN_2, DROWN_3,  // Intermediate states when frog is drowned
    DEAD,   // Frog is dead
    GONE,   // Frog is hidden
    HOME    // Frog is in a home
}

/**
 * Number of frames to change to next state.
 */
private const val STATE_FRAMES = 5
private const val CELL_STEP = GRID_SIZE/ (STATE_FRAMES -1) // GRID_SIZE/ STEP_FRAMES
/**
 * The information of the frog.
 * @property position the position (x and y) of the frog
 * @property dir the direction where the frog is facing (UP, LEFT, DOWN, RIGHT)
 * @property state the state of the frog
 * @property frames the number of frames left to change state
 */
data class Frog(
    val position: Point,
    val dir: Direction,
    val state: FrogState,
    val frames: Int = 0,
)
// create a initial Frog
fun createFrog(): Frog =
    Frog(Point(SCREEN_WIDTH/2, SCREEN_HEIGHT - GRID_SIZE*2), Direction.UP, FrogState.STAY)
// move the frog with a direction corresponding to the key pressed
fun Frogger.moveFrog(facing: Direction?): Frogger {
    val nextPos = frog.doStep(dir= facing)
    return copy(frog = frog.copy(
        dir = facing ?: frog.dir, // if(facing != null) facing else frog.dir
        state = if (frog.state != FrogState.GONE && frog.isDrowned(facing)) FrogState.DROWN_1
            else if (nextPos.isValidPos() && frog.isStableState()) FrogState.MOVE
            else frog.state.changeToIntermediateState(),
        frames = STATE_FRAMES
    ))
}
// fun Frogger.moveFrog(direction: Direction?) = copy(frog = frog.copy(dir = direction ?: frog.dir, state = FrogState.MOVE))
operator fun Point.plus(sum: Point) = Point(x+sum.x,y+sum.y)
// this function is used to position on the Arena is a valid position for the frog
private fun Point.isValidPos() =
    x in 0 .. SCREEN_WIDTH - GRID_SIZE && y in GRID_SIZE*2 .. SCREEN_HEIGHT - GRID_SIZE*2
// this function is used to move the frog step by step
fun Frog.doStep ( dir: Direction?, delta: Int = CELL_STEP) = this.position.plus(
     when(dir){
        Direction.UP -> Point(0, -delta )
        Direction.DOWN -> Point(0,delta)
        Direction.LEFT -> Point(-delta,0)
        Direction.RIGHT -> Point(delta,0)
        null -> Point(0,0)
    }
)
// this function is used to move the frog and the cars along the time
fun Frogger.step(): Frogger {
    val nextPos = frog.doStep(dir= frog.dir)
    val changePos = nextPos.isValidPos() && frog.frames > 1 && frog.isStableState()
    //cars moving on the road and frog moving step by step
    val frog = frog.copy(
        position = if (changePos) nextPos
        else frog.position,
        frames = if ((changePos || !frog.isStableState()) && frog.frames > 1) frog.frames - 1
        else frog.frames,
        state = if (frog.hasColisionWith(cars)) FrogState.SMASH_1
        else if (frog.frames == 1 && frog.isStableState()) FrogState.STAY
        else frog.state.changeToIntermediateState()
    )
    val carsWithScale = cars.map {
        when (it.type.ordinal){
            0, 1, 2, 3, 4 -> it.copy (part = it.part.move() )
            else -> it
        }
    }
    return copy(frog = frog, cars = carsWithScale)
}
// this function is used to check if the frog is in a stable state
private fun Frog.isStableState() = state == FrogState.STAY || state == FrogState.MOVE || state == FrogState.HOME
// this function is used to change the state of the frog when the game is over
private fun FrogState.changeToIntermediateState() = when(this) {
    FrogState.DROWN_1 -> FrogState.DROWN_2
    FrogState.DROWN_2 -> FrogState.DROWN_3
    FrogState.SMASH_1 -> FrogState.SMASH_2
    FrogState.SMASH_2 -> FrogState.SMASH_3
    FrogState.DROWN_3, FrogState.SMASH_3 -> FrogState.DEAD
    FrogState.DEAD -> FrogState.GONE
    else -> this
}
// this function is used to check if the frog have a collision with any of the cars
private fun Frog.hasColisionWith(cars: List<Car>) = state!=FrogState.GONE && true in cars
    .map { (position.x in it.part.toRangeX() || position.x + GRID_SIZE in it.part.toRangeX()) &&
        position.y == it.part.row * GRID_SIZE }
/**
 * this function is used to check if the frog is smashed
 */
private fun Frog.isDrowned(dir: Direction?) = dir == Direction.UP && position.y == SCREEN_HEIGHT/2
