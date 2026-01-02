package pt.isel.daw

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter
import pt.isel.daw.model.output.toOutputMessage

class SseUpdatedChannelEmitterAdapter(
    override val userId: Int,
    private val sseEmitter: SseEmitter,
) : UpdatedChannelEmitter {

    override fun emit(signal: NewMessageEmitter) {
        val msg =
            when (signal) {
                is NewMessageEmitter.Text ->
                    SseEmitter
                        .event()
                        .id(signal.id.toString())
                        .name("message")
                        .data(signal.message.toOutputMessage())

                is NewMessageEmitter.KeepAlive -> SseEmitter.event()
            }
        try {
            sseEmitter.send(msg)
        } catch (ex: Exception) {
            sseEmitter.completeWithError(ex)
        }
    }

    override fun onCompletion(callback: () -> Unit) {
        sseEmitter.onCompletion(callback)
    }

    override fun onError(callback: (Throwable) -> Unit) {
        sseEmitter.onError(callback)
    }
}
