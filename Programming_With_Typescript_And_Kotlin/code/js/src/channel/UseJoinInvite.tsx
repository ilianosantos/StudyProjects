import * as React from 'react';
import { JoinPrivateChannel } from "./LeaveOrJoin";
import { AuthContext } from "../user/AuthProvider";

export function UseJoinInvite() {
    const [inviteCode, setInviteCode] = React.useState("");
    const {setUsername} = React.useContext(AuthContext);

    function onJoinClick(inviteCode: string) {
        JoinPrivateChannel(inviteCode, setUsername);
    }

    return (
        <div>
            <h1>Join Private Channel</h1>
            <form>
                inviteCode: <input name="inviteCode" value={inviteCode} onChange={(e) => setInviteCode(e.target.value)} />
                <br />
                <button type="button" onClick={() => onJoinClick(inviteCode)}>Join private channel</button>
            </form>
        </div>
    );
}
