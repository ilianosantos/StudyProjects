package pt.isel.daw

import java.security.MessageDigest
import java.util.*

class HashEncoder {
    companion object {
        fun hash(input: String): String {
            val messageDigest = MessageDigest.getInstance("SHA256")
            return Base64.getUrlEncoder().encodeToString(
                messageDigest.digest(
                    Charsets.UTF_8.encode(input).array(),
                ),
            )
        }
    }
}
