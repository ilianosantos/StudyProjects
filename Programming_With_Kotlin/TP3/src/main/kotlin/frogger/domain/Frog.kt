package frogger.domain

import frogger.Movable
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
private const val CELL_STEP = GRID_SIZE/ (STATE_FRAMES -1) // STEP_FRAMES for each GRID_SIZE
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
    // val atObject: Boolean = false, // implemented due to the lack of information to know if the frog is in a log or turtle
)
/**
 * creates an initial Frog
 */
fun createFrog(): Frog =
    Frog(Point(SCREEN_WIDTH/2, SCREEN_HEIGHT - GRID_SIZE*2), Direction.UP, FrogState.STAY)

/**
 * move the frog with a direction corresponding to the key pressed
 */
fun Frogger.moveFrog(facing: Direction): Frogger {
    val nextPos = frog.doStep(dir= facing)
    return copy(frog = frog.copy(
        dir = facing,
        state = when {
            over -> frog.state
            nextPos.isValidPos() && frog.isStableState() -> FrogState.MOVE
            else -> frog.changeToIntermediateState()
        },
        frames = STATE_FRAMES
    ),
        homes = homes.map { if (it.canAccept(frog.position)) it.copy(empty = false) else it }
    )
}

/**
 * this function is used to move the frog and the cars along the time
 */
fun Frogger.step(): Frogger {
    val nextPos = frog.doStep(dir= frog.dir)
    val changeNormalPos = nextPos.isValidPos() && frog.frames > 1 && frog.isStableState()
    /**
     * cars moving on the road, turtles and logs moving on the river and frog moving step by step
     */
    return copy( frog = if (frog.position.y == (END_ROW-1) * GRID_SIZE && homes.any { it.canAccept(frog.position) }) createFrog()
            else frog.copy(
            if (changeNormalPos && frog.isStableState()) nextPos
            else frog.moveWith(turtles, logs),
            frames = if (changeNormalPos || (!frog.isStableState()) && frog.frames > 1) frog.frames - 1 else frog.frames,
            state = when {
                frog.hasColisionWith(cars) -> FrogState.SMASH_1
                frog.position.y == (END_ROW-1) * GRID_SIZE && homes.any { !it.canAccept(frog.position) } -> FrogState.GONE
                frog.position.y in (SCREEN_HEIGHT/2 - GRID_SIZE) downTo GRID_SIZE*END_ROW &&
                        (frog.position.x % SCREEN_WIDTH in 0..1 || frog.isDrowned(turtles, logs)) -> FrogState.DROWN_1
                frog.frames == 1 && frog.isStableState() -> FrogState.STAY
                else -> frog.changeToIntermediateState()
            }),
        cars = cars.move(),
        over = frog.state == FrogState.GONE,
        logs = logs.move(),
        turtles = turtles.move()
    )
}

fun List<Car>.move() = map {
   it.copy (part = it.part.move() )
}

fun List<Log>.move() = map { it.move() }
fun List<Turtle>.move() = map { it.move() }

/**
 * this function return a new position by adding the delta to the current position
 */
operator fun Point.plus(sum: Point) = Point(x+sum.x,y+sum.y)
/**
 * this function is used to position on the Arena is a valid position for the frog
 */
private fun Point.isValidPos() =
    x in 0 .. SCREEN_WIDTH - GRID_SIZE && y in GRID_SIZE*2 .. SCREEN_HEIGHT - GRID_SIZE*2
/**
 * this function is used to move the frog step by step
 */
fun Frog.doStep ( dir: Direction?, delta: Int = CELL_STEP):Point {
    val deltaStep = when(dir){
        Direction.UP -> Point(0, -delta )
        Direction.DOWN -> Point(0,delta)
        Direction.LEFT -> Point(-delta,0)
        Direction.RIGHT -> Point(delta,0)
        null -> Point(0,0)
    }
    return position + deltaStep
}
/**
 * this function is used to check if the frog is in a stable state
 */
private fun Frog.isStableState() = state == FrogState.STAY || state == FrogState.MOVE || state == FrogState.HOME
/**
 * this function is used to change the state of the frog when the game is over
 */
private fun Frog.changeToIntermediateState() = when(state) {
    FrogState.DROWN_1 -> FrogState.DROWN_2
    FrogState.DROWN_2 -> FrogState.DROWN_3
    FrogState.SMASH_1 -> FrogState.SMASH_2
    FrogState.SMASH_2 -> FrogState.SMASH_3
    FrogState.DROWN_3, FrogState.SMASH_3 -> FrogState.DEAD
    FrogState.DEAD -> FrogState.GONE
    else -> state
}
/**
 * this function is used to check if the frog have a collision with any of the cars
 */
private fun Frog.hasColisionWith(cars: List<Car>) = state!=FrogState.GONE &&
        cars.any { (position.x in it.part.toRangeX() ||
                position.x + GRID_SIZE in it.part.toRangeX()) &&
                position.y == it.part.row * GRID_SIZE
        }
/**
 * this function is used to check if the frog is drowned
 */
private fun Frog.isDrowned(turtles: List<Turtle>, logs: List<Log>):Boolean {
    val frogInLogPosition = logs.any { this.hasObstacle(it.part) }
    val frogInTurtlePosition = turtles.any { hasObstacle(it.part) && (!it.diver || it.state() != TurtleState.UNDER_WATER ) }
    return state!=FrogState.GONE && position.y % GRID_SIZE == 0 && ! (frogInTurtlePosition || frogInLogPosition)
}

/**
 * this function is used to check if the frog has an obstacle when he's in the river
 */
private fun Frog.hasObstacle(obs: Movable) = position.y == obs.row * GRID_SIZE &&
        obs.toRangeX().contains(position.x) && obs.toRangeX().contains(position.x + GRID_SIZE)

/**
 * This function is used to move the frog with the turtles and logs or if he's not in the river keep his position
 */
private fun Frog.moveWith(turtles: List<Turtle>, logs: List<Log>) = when {
    logs.any { hasObstacle(it.part) } -> Point(position.x + logs.filter { hasObstacle(it.part) }.map { it.part.speed }.first(), position.y)
    turtles.any { hasObstacle(it.part) } -> Point(position.x + turtles.filter { hasObstacle(it.part) }.map { it.part.speed }.first(), position.y)
    else -> position
}