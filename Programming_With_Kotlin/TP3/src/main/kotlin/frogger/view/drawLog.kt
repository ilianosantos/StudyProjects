package frogger.view

import frogger.domain.Log
import pt.isel.canvas.Canvas

// Draws the logs in the game
fun Canvas.drawLog(logs: List<Log>, gridSize: Int, spriteXlist: List<Int>) =
    logs.forEach { log ->
        for (i in 0 until log.part.size) {
            val extremityLeft = i == 0
            val extremityRight = i == log.part.size -1
            drawImage(
                "frogger|${if (extremityLeft)
                    spriteXlist.first()
                else if (extremityRight)
                    spriteXlist.last()
                else
                    spriteXlist[1]},134," +
                        "${if (extremityLeft || extremityRight) 13 else 16 }," +
                        "16",
                log.part.x + i * gridSize,
                log.part.row * gridSize,
                gridSize,
                gridSize
            )
        }
    }