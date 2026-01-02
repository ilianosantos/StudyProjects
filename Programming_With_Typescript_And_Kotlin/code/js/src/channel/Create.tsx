import * as React from 'react';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { AuthContext } from "../user/AuthProvider";
import { verifyResponse } from "../auxiliar/Utils";

const CREATE_PATH = MAIN_ADDRESS + '/channels/create'

export function CreateChannel() {
    const [state, dispatch] = React.useReducer(reducer, {
        tag: "editing", inputs: {
            name: "",
            type: ""
        }
    });
    const {setUsername} = React.useContext(AuthContext);

    function handleSubmit(type: string) {
        if (state.tag == "editing") {
            dispatch({ type: 'submit' });
            fetch(CREATE_PATH, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    name: state.inputs.name,
                    type: type,
                }),
            })
            .then((res) => {
                const error = verifyResponse(res, setUsername);
                if (error) throw new Error(error)
                res.status == 201 ? dispatch({ type: "success" })
                : dispatch({ type: "error", message: `Failed to create channel ${state.inputs.name}!`});
            })
            .catch((err) => {
                dispatch({ type: "error", message: err.message })
            })
        }
    }

    function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
        dispatch({ type: "edit", inputName: event.target.name, inputValue: event.target.value })
    }

    const { name } = state.tag === "editing" ? state.inputs : { name: "" }
    return (
        <div>
            <h1>Create Channel</h1>
            Name: <input name="name" type="text" value={name} onChange={handleChange} />
            <br />
            {state.tag === 'editing' && state.error && <p>Error: {state.error}</p>}
            <button style={{ marginRight: '5px' }} onClick={() => handleSubmit('PUBLIC')}>Create Public</button>
            <button style={{ marginLeft: '5px' }} onClick={() => handleSubmit('PRIVATE')}>Create Private</button>
            <br />
        </div>
    )
}

type State =
    { tag: 'editing'; error?: string, inputs: { name: string, type: string }; } |
    { tag: 'submitting' }

type Action =
    { type: "edit", inputName: string, inputValue: string } |
    { type: "submit" } |
    { type: "success" } |
    { type: "error", message: string }

function reducer(state: State, action: Action): State {
    switch (state.tag) {
        case 'editing':
            switch (action.type) {
                case "edit": return { tag: 'editing', inputs: { ...state.inputs, [action.inputName]: action.inputValue } }
                case "submit": return { tag: 'submitting' }
            }
        case 'submitting':
            switch (action.type) {
                case "success": return { tag: 'editing', inputs: { name: "", type: "" } }
                case "error": return { tag: 'editing', error: action.message, inputs: { name: "", type: "" } }
            }
    }
}
