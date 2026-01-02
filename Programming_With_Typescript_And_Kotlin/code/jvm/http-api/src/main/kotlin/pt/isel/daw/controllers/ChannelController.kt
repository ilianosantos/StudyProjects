package pt.isel.daw.controllers

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter
import pt.isel.daw.*
import pt.isel.daw.model.*
import pt.isel.daw.model.input.*
import pt.isel.daw.model.output.*
import java.util.concurrent.TimeUnit

@RestController
@RequestMapping("/api/channels")
class ChannelController (
    private val channelService: ChannelService,
    private val messageService: MessageService
) {
    /**
     * Listens to the channel with the given id
     * Types of http statuses returned: OK
     */
    @GetMapping("/{channelId}/listen")
    fun listen(
        @PathVariable channelId: Int,
        user: AuthenticatedUser
    ): SseEmitter {
        val sseEmitter = SseEmitter(TimeUnit.HOURS.toMillis(1))
        messageService.addEmitter(
            channelId,
            SseUpdatedChannelEmitterAdapter(
                user.user.id,
                sseEmitter,
            ),
        )
        return sseEmitter
    }

    /**
     * Closes the listener from the channel with the given id
     * Types of http statuses returned: OK
     */
    @DeleteMapping("/{channelId}/listen/close")
    fun removeListener(
        @PathVariable channelId: Int,
        user: AuthenticatedUser
    ): ResponseEntity<Boolean> {
        val result = messageService.removeListener(user.user.id, channelId)
        return ResponseEntity.ok(result)
    }

    /**
     * Gets all public channels
     * Types of http statuses returned: OK, INTERNAL_SERVER_ERROR
     */
    @GetMapping("/public")
    fun getAllPublicChannels(): ResponseEntity<Any> =
        when(val result = channelService.getAllPublicChannels()) {
            is Success -> {
                val toReturn = result.value.map {
                    it.toOutputChannel()
                }
                ResponseEntity.ok(toReturn)
            }
            is Failure -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
        }

    /**
     * Gets all channels of the user with the given id
     * Types of http statuses returned: OK
     */
    @GetMapping("/all")
    fun getAllUserChannels(
        user: AuthenticatedUser
    ): ResponseEntity<List<OutputChannel>> {
        val result = channelService.getAllChannelsByUserId(user.user.id)
        return ResponseEntity.ok(result.map { it.toOutputChannel() })
    }

    /**
     * Gets the channel with the given id and user
     * Types of http statuses returned: OK, NOT_FOUND, INTERNAL_SERVER_ERROR
     */
    @GetMapping("/{channelId}")
    fun getChannelById(
        @PathVariable channelId: Int,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = channelService.getChannelByUserAndChannelId(user.user.id, channelId)
        return when(result) {
            is Success -> ResponseEntity.ok(result.value.toOutputChannel())
            is Failure -> when(result.value) {
                is ChannelError.ChannelNotFound -> Problem.ChannelNotFound.response(HttpStatus.NOT_FOUND)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Create a channel with the given name and type
     * Types of http statuses returned: OK, BAD_REQUEST, INTERNAL_SERVER_ERROR
     */
    @PostMapping("/create")
    fun createChannel(
        @RequestBody inputChannel: InputChannel,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        if (inputChannel.name.isNullOrBlank() || inputChannel.type.isNullOrBlank()) {
            return Problem.InvalidInputChannel.response(HttpStatus.BAD_REQUEST)
        }
        val channelKind = when(inputChannel.type.uppercase()) {
            "PUBLIC" -> ChannelKind.PUBLIC
            "PRIVATE" -> ChannelKind.PRIVATE
            else -> return Problem.InvalidInputChannel.response(HttpStatus.BAD_REQUEST)
        }
        val result = channelService.createChannel(inputChannel.name, user.user.id, channelKind)
        return when(result) {
            is Success -> ResponseEntity.status(HttpStatus.CREATED).body(
                OutputCreateChannel(
                    result.value.id,
                    result.value.inviteCodeReadOnly,
                    result.value.inviteCodeWithWrite
                )
            )
            is Failure -> when(result.value) {
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Join a public channel with the given id
     * Types of http statuses returned: OK, NOT_FOUND, INTERNAL_SERVER_ERROR, BAD_REQUEST
     */
    @PostMapping("/join/public")
    fun joinPublicChannel(
        @RequestBody inputChannel: InputPublicChannelJoin,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = channelService.addUserToPublicChannel(user.user.id, inputChannel.id)
        return when(result) {
            is Success -> ResponseEntity.ok().build()
            is Failure -> when(result.value) {
                is ChannelError.ChannelNotFound -> Problem.ChannelNotFound.response(HttpStatus.NOT_FOUND)
                is ChannelError.AlreadyMember -> Problem.AlreadyMember.response(HttpStatus.BAD_REQUEST)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Join a private channel with an invitation code
     * Types of http statuses returned: OK, NOT_FOUND, INTERNAL_SERVER_ERROR, BAD_REQUEST
     */
    @PostMapping("/join/private")
    fun joinPrivateChannel(
        @RequestBody inputChannel: InputPrivateChannelJoin,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = channelService.addUserToPrivateChannel(user.user.id, inputChannel.inviteCode)
        return when(result) {
            is Success -> ResponseEntity.ok().build()
            is Failure -> when(result.value) {
                is ChannelError.ChannelNotFound -> Problem.ChannelNotFound.response(HttpStatus.NOT_FOUND)
                is ChannelError.AlreadyMember -> Problem.AlreadyMember.response(HttpStatus.BAD_REQUEST)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Leave a channel with the given id
     * Types of http statuses returned: OK, BAD_REQUEST, INTERNAL_SERVER_ERROR
     */
    @DeleteMapping("/leave")
    fun leaveChannel(
        @RequestBody inputChannel: InputChannelLeave,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = channelService.removeUserFromChannel(inputChannel.channelId, user.user.id)
        return when(result) {
            is Success -> ResponseEntity.ok().build()
            is Failure -> when(result.value) {
                is ChannelError.InvalidChannelMembers -> Problem.InvalidCredentials.response(HttpStatus.BAD_REQUEST)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Gets the channel messages with the given id
     * Types of http statuses returned: OK, NOT_FOUND, UNAUTHORIZED, INTERNAL_SERVER_ERROR
     */
    @GetMapping("/{channelId}/chat/{skip}/{max}")
    fun getMessages(
        @PathVariable channelId: Int,
        @PathVariable skip: Int,
        @PathVariable max: Int,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = messageService.getMessages(user.user.id, channelId, skip, max)
        return when(result) {
            is Success -> ResponseEntity.ok(result.value.map { it.toOutputMessage() })
            is Failure -> when(result.value) {
                is MessageError.MessageChannelNotFound -> Problem.ChannelNotFound.response(HttpStatus.NOT_FOUND)
                is MessageError.DoesNotBelongToChannel -> Problem.DoesNotBelongToChannel.response(HttpStatus.UNAUTHORIZED)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }

    /**
     * Sends a message to a channel
     * Types of http statuses returned: OK, BAD_REQUEST, NOT_FOUND, UNAUTHORIZED, INTERNAL_SERVER_ERROR
     */
    @PostMapping("/{channelId}/chat/send")
    fun sendMessage(
        @PathVariable channelId: Int,
        @RequestBody inputMessage: InputMessage,
        user: AuthenticatedUser
    ): ResponseEntity<Any> {
        val result = messageService.sendMessage(user.user.id, channelId, inputMessage.text)
        return when(result) {
            is Success -> ResponseEntity.status(HttpStatus.CREATED).build()
            is Failure -> when(result.value) {
                is MessageError.MessageChannelNotFound -> Problem.ChannelNotFound.response(HttpStatus.NOT_FOUND)
                is MessageError.DoesNotBelongToChannel -> Problem.DoesNotBelongToChannel.response(HttpStatus.UNAUTHORIZED)
                is MessageError.NoPermission -> Problem.NoPermission.response(HttpStatus.UNAUTHORIZED)
                is MessageError.InvalidInputMessage -> Problem.InvalidInputMessage.response(HttpStatus.BAD_REQUEST)
                else -> Problem.InternalError.response(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
    }
}
