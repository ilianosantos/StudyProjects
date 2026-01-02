import * as React from 'react';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { verifyResponse } from "../auxiliar/Utils";
import { AuthContext } from "./AuthProvider";

const CREATE_PATH = MAIN_ADDRESS + '/user/invite';

export function CreateRegistrationInvite() {
    const [state, dispatch] = React.useReducer(reducer, { tag: "idle" });
    const { setUsername } = React.useContext(AuthContext);

    function handleSubmit() {
        if (state.tag === "idle") {
            dispatch({ type: 'submit' });
            fetch(CREATE_PATH, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
            })
            .then((res) => {
                const error = verifyResponse(res, setUsername);
                if (error) throw new Error(error)
                return res.json()
            })
            .then((data) => {
                dispatch({ type: "success", invite: data });
                navigator.clipboard.writeText(data.code).then(() => {
                    alert('Invite code copied to clipboard!');
                }).catch(err => {
                    console.error('Failed to copy: ', err);
                });
            })
            .catch((err) => {
                dispatch({ type: "error", message: err.message });
            });
        }
    }

    return (
        <div>
            <h1>Create a Registration Invite</h1>
            <br />
            {state.tag === 'idle' && !state.invite && <button onClick={handleSubmit}>Create</button>}
            {state.tag === 'idle' && state.error && <p>Error: {state.error}</p>}
        </div>
    );
}

type State =
    { tag: 'idle'; error?: string; invite?: { code: string } } |
    { tag: 'submitting' }

type Action =
    { type: "submit" } |
    { type: "success", invite: { code: string } } |
    { type: "error", message: string }

function reducer(state: State, action: Action): State {
    switch (state.tag) {
        case 'idle':
            switch (action.type) {
                case "submit": return { tag: 'submitting' };
                case "success": return { tag: 'idle', invite: action.invite };
                case "error": return { tag: 'idle', error: action.message };
            }
        case 'submitting':
            switch (action.type) {
                case "success": return { tag: 'idle', invite: action.invite };
                case "error": return { tag: 'idle', error: action.message };
            }
    }
}
