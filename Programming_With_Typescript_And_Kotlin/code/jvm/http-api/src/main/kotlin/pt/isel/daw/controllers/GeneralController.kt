package pt.isel.daw.controllers

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")
class GeneralController {
    /**
     * Entry point
     * Types of http statuses returned: OK
     */
    @GetMapping("/")
    fun index() = "Welcome to entry point"
}
