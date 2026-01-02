package pt.isel.daw.pipeline

import jakarta.servlet.http.Cookie
import org.springframework.stereotype.Component
import pt.isel.daw.AuthenticatedUser
import pt.isel.daw.Success
import pt.isel.daw.UserService

@Component
class RequestTokenProcessor(
    val usersService: UserService,
) {
    fun processCookies(cookies: Array<Cookie>?)
    : AuthenticatedUser? {
        val tokenCookie = cookies?.find { it.name == TOKEN_COOKIE_NAME } ?: return null
        val token = tokenCookie.value
        return usersService.getUserByToken(token).let {
            if (it is Success) AuthenticatedUser(
                it.value,
                token,
            )
            else null
        }
    }

    companion object {
        const val TOKEN_COOKIE_NAME = "token"
    }
}
