package pt.isel.daw.fakes

import pt.isel.daw.*

internal val owner = User(0,"Alice","alice@example.com",PasswordValidationInfo("1234567890"))

internal val member = User(1,"Bob","bob@example.com",PasswordValidationInfo("2345678901"))

internal val channel = Channel(0,"General", owner, ChannelKind.PUBLIC, null, null)

internal val part = Participant(0, owner, channel, ParticipantKind.OWNER)

internal val message = Message(0,"Hello", part)
