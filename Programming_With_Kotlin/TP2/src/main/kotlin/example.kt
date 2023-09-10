enum class Direction {
    LEFT, RIGHT, UP, DOWN
}
/*
forEachIndexed{ idx, elem ->
    drawImage("frogger|$elem,9,9", iX+idx* cell, iY, cell, cell)
}
 */

fun List<Char>.Ramgi(a:Int, b:(Char) -> String ): Unit{
    for(i in 0 .. a){
        val d = b(this[i])
        println(d)
    }
}
fun main() {
    listOf<Char>('a','b','c').Ramgi(2){ e -> "olá " + e }
}