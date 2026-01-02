import { MAIN_ADDRESS } from "../auxiliar/Data";

const SEND_MESSAGE_PATH = MAIN_ADDRESS + '/channels/';

export function SendMessage(channelId: string, msg: string) {    
    if (channelId && msg) {
        let isCancelled = false;

        fetch(`${SEND_MESSAGE_PATH}${channelId}/chat/send`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                text: msg,
            }),
        })
        .then((res) => {
            if (!isCancelled && res.ok) {
                // alert(`Message sent to channel ${channelId}!`);
            } else if (res.status == 401) {
                alert('You are not authorized to send messages to this channel!');
            } else {
                alert(`Failed to send message to channel ${channelId}!`);
            }
        })
        .catch((err) => {
            alert(err);
        });

        return () => {
            isCancelled = true;
        };
    }
}