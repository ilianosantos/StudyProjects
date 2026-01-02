import * as React from 'react';
import { useNavigate } from 'react-router-dom';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { AuthContext } from "../user/AuthProvider";
import { verifyResponse } from "../auxiliar/Utils";

const LIST_USER_CHANNELS_PATH = MAIN_ADDRESS + '/channels/all'

type Channel = {
    "id": number,
    "name": string,
    "owner": {
        "id": number,
        "name": string,
        "email": string
    },
    "type": string
}

export function OwnChannels() {
    const [channels, setChannels] = React.useState<Channel[]>([])
    const { setUsername } = React.useContext(AuthContext);
    const navigate = useNavigate();

    React.useEffect(() => {
        let isCancelled = false
        fetch(LIST_USER_CHANNELS_PATH)
            .then(res => {
                const error = verifyResponse(res, setUsername);
                if (error) throw new Error(error)
                return res.json()
            })
            .then(data => {
                if (!isCancelled) {
                    const ch = (data as Channel[])
                    setChannels(ch)
                }
            })
            .catch(error => console.log(error))
        return () => { isCancelled = true }
    }, [])

    function onOpenClick(id: number) {
        navigate(`/chat/${id}`);
    }

    return (
        <div>
            <h1>My channels</h1>
            <ul className="result">
                {
                    channels.map((ch: Channel) => (
                        <li key={ch.id}>
                            {ch.name} - {ch.type}
                            <br />
                            <button onClick={() => onOpenClick(ch.id)}>
                                Open chat
                            </button>
                        </li>
                    ))
                }
            </ul>
        </div>
    )
}