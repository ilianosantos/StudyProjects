import { MAIN_ADDRESS } from "../auxiliar/Data";
import { verifyResponse } from "../auxiliar/Utils";

const PRIVATE_JOIN_PATH = MAIN_ADDRESS + '/channels/join/private';
const PUBLIC_JOIN_PATH = MAIN_ADDRESS + '/channels/join/public';
const LEAVE_PATH = MAIN_ADDRESS + '/channels/leave';

function JoinPublicChannel(channelId: string, setUsername: (username: string | undefined) => void) {
    if (channelId) {
        fetch(PUBLIC_JOIN_PATH, { 
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({ id: channelId })
        })
        .then(res => {
            const error = verifyResponse(res, setUsername);
            if (error) throw new Error(error)
            res.ok
                ? alert(`You have joined the channel ${channelId}!`)
                : alert(`Failed to join the channel!`)
        })
        .catch(error => {
            alert(error)
        });
    }
}

function JoinPrivateChannel(inviteCode: string, setUsername: (username: string | undefined) => void) {
    if (inviteCode) {
        fetch(PRIVATE_JOIN_PATH, { 
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({ inviteCode: inviteCode })
        })
        .then(res => {
            const error = verifyResponse(res, setUsername);
            if (error) throw new Error(error)
            res.ok 
                ? alert(`You have joined the channel!`)
                : alert(`Failed to join the channel!`);
        })
        .catch(error => {
            alert(error);
        });
    }
}

function LeaveChannel(channelId: string, setUsername: (username: string | undefined) => void) {
    if (channelId) {
        fetch(LEAVE_PATH, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({ channelId })
        })
        .then(res => {
            const error = verifyResponse(res, setUsername);
            if (error) throw new Error(error)
            res.ok 
                ? alert(`You have left the channel ${channelId}!`)
                : alert(`Failed to leave the channel ${channelId}!`);
        })
        .catch(error => {
            alert(error);
        });
    }
}

export {
    JoinPublicChannel,
    JoinPrivateChannel,
    LeaveChannel
}
