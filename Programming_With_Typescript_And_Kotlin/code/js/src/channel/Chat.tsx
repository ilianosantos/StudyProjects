import * as React from 'react';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { SendMessage } from './SendMessage';
import { Message } from '../auxiliar/Data';
import { useParams } from "react-router-dom";
import { AuthContext } from "../user/AuthProvider";
import { LeaveChannel } from "./LeaveOrJoin";
import '../../public/styles/Chat.css';

const CHANNELS_PATH = MAIN_ADDRESS + '/channels/'

type State = {
    messages: Message[];
    text: string;
    channelInfo: any;
};

type Action =
    { type: 'SET_MESSAGES'; payload: Message[] } |
    { type: 'ADD_MESSAGE'; payload: Message } |
    { type: 'SET_TEXT'; payload: string } |
    { type: 'SET_CHANNEL_INFO'; payload: any } |
    { type: 'INCREMENT_SKIP' };

const initialState: State = {
    messages: [],
    text: '',
    channelInfo: null,
};

function reducer(state: State, action: Action): State {
    switch (action.type) {
        case 'SET_MESSAGES':
            return { ...state, messages: [...action.payload, ...state.messages] };
        case 'ADD_MESSAGE':
            return { ...state, messages: [...state.messages, action.payload] };
        case 'SET_TEXT':
            return { ...state, text: action.payload };
        case 'SET_CHANNEL_INFO':
            return { ...state, channelInfo: action.payload };
        default:
            return state;
    }
}

export function Chat() {
    const [state, dispatch] = React.useReducer(reducer, initialState);
    const { messages, text, channelInfo } = state;
    const { username, setUsername } = React.useContext(AuthContext);
    const { channelId } = useParams<{ channelId: string }>();
    const messageListRef = React.useRef<HTMLUListElement>(null);
    const oldScroll = React.useRef(0);

    const listenPath = CHANNELS_PATH + `${channelId}/listen`
    const closeListenPath = listenPath + '/close'

    React.useEffect(() => {
        if (channelId) {
            fetchMessages(messages.length, 4);

            fetch(`${CHANNELS_PATH}${channelId}`)
                .then(response => response.json())
                .then(data => {
                    console.log('Fetched channel info:', data)
                    dispatch({ type: 'SET_CHANNEL_INFO', payload: data });
                })
                .catch(error => {
                    console.log('Error fetching channel info:', error)
                })

            const eventSource = new EventSource(`${listenPath}`, { withCredentials: true });
            eventSource.onmessage = (event) => {
                console.log('Received new message:', event.data)
                const newMessage = JSON.parse(event.data) as Message;
                dispatch({ type: 'ADD_MESSAGE', payload: newMessage });
            };

            eventSource.onerror = (error) => {
                console.error('EventSource failed:', error);
                closeEventSource(eventSource);
            };

            return () => {
                closeEventSource(eventSource);
            };
        }
    }, [channelId])

    React.useEffect(() => {
        if (messageListRef.current && (messageListRef.current.scrollTop === 0 ||
            messageListRef.current.scrollTop + messageListRef.current.clientHeight*2 >= messageListRef.current.scrollHeight)) {
            messageListRef.current.scrollTop = messageListRef.current.scrollHeight - oldScroll.current;
            oldScroll.current = 0;
        }
    }, [messages]);

    function closeEventSource(eventSource: EventSource) {
        console.log('Closing EventSource')
        eventSource.close();
        fetch(closeListenPath, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
        })
    }

    function fetchMessages(skip: number, limit: number) {
        fetch(`${CHANNELS_PATH}${channelId}/chat/${skip}/${limit}`)
            .then(response => response.json())
            .then(data => {
                console.log('Fetched messages:', data)
                dispatch({ type: 'SET_MESSAGES', payload: data });
            })
            .catch(error => {
                console.log('Error fetching messages:', error)
            })
    }

    function onLeaveClick() {
        LeaveChannel(channelId, setUsername)
    }

    function copyToClipboard(text: string) {
        navigator.clipboard.writeText(text).then(() => {
            alert('Invite code copied to clipboard!');
        }).catch(err => {
            console.error('Failed to copy: ', err);
        });
    }

    function handleSendMessage() {
        SendMessage(channelId, text);
        dispatch({ type: 'SET_TEXT', payload: '' });
    }

    function handleScroll(event: React.UIEvent<HTMLUListElement>) {
        if (event.currentTarget.scrollTop === 0) {
            oldScroll.current = event.currentTarget.scrollHeight - event.currentTarget.scrollTop;
            dispatch({ type: 'INCREMENT_SKIP' });
            fetchMessages(messages.length, 4);
        }
    }

    return (
        <div className="chatContainer">
            <div className="chatMain">
                <h1 className="chatHeader">Chat for Channel {channelId}</h1>
                <ul className="messageList" ref={messageListRef} onScroll={handleScroll}>
                    {
                        messages.map((msg: Message) => (
                            <li key={msg.time} className={`messageItem ${msg.author.user.name === username ? 'right' : ''}`}>
                                <div className="messageAuthor">{msg.author.user.name}</div>
                                <div className="messageText">{msg.text}</div>
                                <div className="messageTime">{new Date(msg.time).toLocaleString()}</div>
                            </li>
                        ))
                    }
                </ul>
                <div className="inputBox">
                    <input
                        className="inputField"
                        name="text"
                        value={text}
                        onChange={(e) => dispatch({ type: 'SET_TEXT', payload: e.target.value })}
                        placeholder="Type your message here..."
                    />
                    <button className="sendButton" onClick={handleSendMessage}>
                        Send
                    </button>
                </div>
            </div>
            <div className="chatInfo">
                {channelInfo && (
                    <>
                        <h2>Channel Info</h2>
                        <p><strong>Owner:</strong> {channelInfo.owner.name}</p>
                        <p><strong>Type:</strong> {channelInfo.type}</p>
                        {channelInfo.type !== 'PUBLIC' && (
                            <>
                                <p>
                                    <strong>Invite Code (Write):</strong>
                                    {channelInfo.inviteCodeWithWrite && (
                                        <button onClick={() => copyToClipboard(channelInfo.inviteCodeWithWrite)}>Copy</button>
                                    )}
                                </p>
                                <p>
                                    <strong>Invite Code (Read Only):</strong>
                                    {channelInfo.inviteCodeReadOnly && (
                                        <button onClick={() => copyToClipboard(channelInfo.inviteCodeReadOnly)}>Copy</button>
                                    )}
                                </p>
                            </>
                        )}
                        <button onClick={onLeaveClick}>Leave Channel</button>
                    </>
                )}
            </div>
        </div>
    );
}
