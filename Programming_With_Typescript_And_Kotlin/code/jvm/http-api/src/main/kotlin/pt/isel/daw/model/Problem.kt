package pt.isel.daw.model

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import java.net.URI

private const val MEDIA_TYPE = "application/problem+json"
private const val PROBLEM_URI_PATH = "https://github.com/isel-leic-daw/2024-daw-leic53d-g04-53d/tree/main/docs/problems"

sealed class Problem(
    typeUri: URI,
) {
    val type = typeUri.toString()
    val title = typeUri.toString().split("/").last()

    fun response(status: HttpStatus): ResponseEntity<Any> = ResponseEntity.status(status)
        .header("Content-Type", MEDIA_TYPE)
        .body(this)


    // User errors
    data object UserAlreadyExists : Problem(URI("$PROBLEM_URI_PATH/user-already-exists"))
    data object PasswordTooWeak : Problem(URI("$PROBLEM_URI_PATH/password-too-weak"))
    data object InvalidEmail : Problem(URI("$PROBLEM_URI_PATH/invalid-email"))
    data object InvalidCredentials : Problem(URI("$PROBLEM_URI_PATH/invalid-credentials"))
    data object EmailAlreadyInUse : Problem(URI("$PROBLEM_URI_PATH/email-already-in-use"))
    data object FailedToCreateToken : Problem(URI("$PROBLEM_URI_PATH/failed-to-create-token"))
    data object InvalidRegistrationInvite : Problem(URI("$PROBLEM_URI_PATH/invalid-registration-invite"))

    // Channel errors
    data object ChannelNotFound : Problem(URI("$PROBLEM_URI_PATH/channel-not-found"))
    data object DoesNotBelongToChannel : Problem(URI("$PROBLEM_URI_PATH/does-not-belong-to-channel"))
    data object InvalidInputChannel : Problem(URI("$PROBLEM_URI_PATH/invalid-input-channel"))
    data object AlreadyMember : Problem(URI("$PROBLEM_URI_PATH/already-member"))
    data object NoPermission : Problem(URI("$PROBLEM_URI_PATH/no-permission"))

    // Message errors
    data object InvalidInputMessage : Problem(URI("$PROBLEM_URI_PATH/invalid-input-message"))

    // General errors
    data object NeedNotNullParameters : Problem(URI("$PROBLEM_URI_PATH/need-not-null-parameters"))
    data object InternalError : Problem(URI("$PROBLEM_URI_PATH/internal-error"))
}
