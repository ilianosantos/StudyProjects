import * as React from 'react';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { JoinPublicChannel } from "./LeaveOrJoin";
import { Channel } from "../auxiliar/Data";
import { AuthContext } from "../user/AuthProvider";

const LIST_PUBLIC_CHANNELS_PATH = MAIN_ADDRESS + '/channels/public'

export function PublicChannels(){
    const [channels, setChannels] = React.useState<Channel[]>([])
    const {setUsername} = React.useContext(AuthContext);

    React.useEffect(() => {
        let isCancelled = false
        fetch(LIST_PUBLIC_CHANNELS_PATH)
        .then(response => response.json())
        .then(data => {
            if(!isCancelled){
                const ch = (data as Channel[])
                setChannels(ch)
            }
        })
        .catch(error => console.log(error))
        return () => {isCancelled = true}
    }, [])

    function onJoinClick(id: number) {
        JoinPublicChannel(id.toString(), setUsername)
    }

    return (
        <div>
            <h1>All public channels</h1>
            <ul className = "result">
                {
                    channels.map((ch: Channel)=> (
                        <li key={ch.id}>
                            {ch.name}
                            <button onClick={() => onJoinClick(ch.id)}>
                                Join
                            </button>
                        </li>
                    ))
                }
            </ul>
        </div>
    )
}