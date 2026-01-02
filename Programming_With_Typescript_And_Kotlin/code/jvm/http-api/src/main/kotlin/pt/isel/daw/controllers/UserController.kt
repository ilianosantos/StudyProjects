package pt.isel.daw.controllers

import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseCookie
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pt.isel.daw.*
import pt.isel.daw.model.*
import pt.isel.daw.model.input.InputCreateUser
import pt.isel.daw.model.input.LoginInput
import pt.isel.daw.model.output.UserHomeOutputModel
import pt.isel.daw.model.output.toOutputUser
import java.time.Duration

const val TOKEN_COOKIE = "token"

@RestController
@RequestMapping("/api/user")
class UserController (
    private val userService: UserService
) {
    /**
     * Invites a user to register with the given code and deletes it if the user was created
     * Types of http statuses returned: OK, BAD_REQUEST, CONFLICT, INTERNAL_SERVER_ERROR
     */
    @PostMapping("/register/{code}")
    fun createUser(
        @PathVariable code: String,
        @RequestBody inputUser: InputCreateUser
    ): ResponseEntity<Any> {
        val isCodeValid = userService.isRegistrationInviteValid(code)
        when (isCodeValid) {
            is Success -> {
                if (!isCodeValid.value) return Problem.InvalidRegistrationInvite.response(HttpStatus.BAD_REQUEST)
                val wasCreated = userService.createUser(inputUser.name, inputUser.email, inputUser.password)
                when (wasCreated) {
                    is Success -> {
                        userService.deleteRegistrationInvite(code)
                        return ResponseEntity.status(HttpStatus.CREATED).body(wasCreated.value.toOutputUser())
                    }
                    is Failure -> return when (wasCreated.value) {
                        is UserError.NeedNotNullParameters -> Problem.NeedNotNullParameters.response(HttpStatus.BAD_REQUEST)
                        is UserError.PasswordTooWeak -> Problem.PasswordTooWeak.response(HttpStatus.BAD_REQUEST)
                        is UserError.InvalidEmail -> Problem.InvalidEmail.response(HttpStatus.BAD_REQUEST)
                        is UserError.UserAlreadyExists -> Problem.UserAlreadyExists.response(HttpStatus.CONFLICT)
                        is UserError.EmailAlreadyInUse -> Problem.EmailAlreadyInUse.response(HttpStatus.CONFLICT)
                        else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
                    }
                }
            }
            is Failure -> return Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    /**
     * Creates a registration invite
     * Types of http statuses returned: OK, INTERNAL_SERVER_ERROR
     */
    @PostMapping("/invite")
    fun createRegistrationInvite(user: AuthenticatedUser): ResponseEntity<Any> {
        return when (val invite = userService.createRegistrationInvite()) {
            is Success -> ResponseEntity.status(HttpStatus.CREATED).body(invite.value)
            is Failure -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    /**
     * Gets the home of the user
     * Types of http statuses returned: OK
     */
    @GetMapping("/home")
    fun getUserHome(user: AuthenticatedUser): ResponseEntity<UserHomeOutputModel> =
        ResponseEntity.ok().body(UserHomeOutputModel(user.user.id, user.user.name, user.user.email))

    /**
     * Logs in a user with the given credentials
     * Types of http statuses returned: OK, UNAUTHORIZED, INTERNAL_SERVER_ERROR
     */
    @PostMapping("/login")
    fun login(
        @RequestBody input: LoginInput
    ): ResponseEntity<Any> {
        val result = userService.login(input.username, input.password)
        return when (result) {
            is Success -> {
                val cookie = ResponseCookie.from(TOKEN_COOKIE, result.value.validationInfo)
                    .httpOnly(true)
                    .path("/")
                    .maxAge(Duration.ofDays(1))
                    .sameSite("None")
                    .secure(true)
                    .build()
                ResponseEntity.status(HttpStatus.CREATED)
                    .header(HttpHeaders.SET_COOKIE, cookie.toString())
                    .build()
            }
            is Failure -> when (result.value) {
                is UserError.InvalidCredentials -> Problem.InvalidCredentials.response(HttpStatus.UNAUTHORIZED)
                is UserError.FailedToCreateToken -> Problem.FailedToCreateToken.response(HttpStatus.INTERNAL_SERVER_ERROR)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Logs out a user and invalidates the token
     * Types of http statuses returned: OK, INTERNAL_SERVER_ERROR
     */
    @DeleteMapping("/logout")
    fun logout(user: AuthenticatedUser) : ResponseEntity<Any> {
        val result = userService.logout(TokenValidationInfo(user.token))
        return when (result) {
            is Success -> {
                val expiredCookie = ResponseCookie.from(TOKEN_COOKIE, "")
                    .httpOnly(true)
                    .path("/")
                    .maxAge(Duration.ofDays(0))
                    .sameSite("None")
                    .secure(true)
                    .build()
                ResponseEntity.ok()
                    .header(HttpHeaders.SET_COOKIE, expiredCookie.toString())
                    .build()
            }

            is Failure -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
}
