package pt.isel.daw.model.output

import pt.isel.daw.User

data class OutputUser (
    val id: Int,
    val name: String,
    val email: String,
)

fun User.toOutputUser() = OutputUser(
    id = id,
    name = name,
    email = email,
)
