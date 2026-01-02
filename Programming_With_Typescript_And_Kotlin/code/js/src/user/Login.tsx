import * as React from 'react'
import { Navigate, useLocation } from 'react-router-dom'
import { AuthContext } from './AuthProvider'
import { MAIN_ADDRESS } from "../auxiliar/Data"

const LOGIN_PATH = MAIN_ADDRESS + '/user/login'
const HOME_PATH_EXTENSION = '/home'

export function Login() {
    const location = useLocation()
    const {setUsername} = React.useContext(AuthContext)
    const [state, dispatch] = React.useReducer(reducer, {
        tag: "editing", inputs: {
            username: "",
            password: ""
        }
    } as State)

    if (state.tag === "redirect") {
        return <Navigate to={location.state?.source || HOME_PATH_EXTENSION} replace={true} />
    }

    function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
        dispatch({ type: "edit", inputName: event.target.name, inputValue: event.target.value })
    }

    function titleToMessage(title: string) {
        switch (title) {
            case "invalid-credentials" : return "Invalid credentials!"
            case "failed-to-create-token" : return "Server has encountered an error!"
            default: return 'Failed to login!'
        }
    }

    async function handleSubmit() {
        if (state.tag === "editing") {
            dispatch({ type: 'submit' });
            const {username, password} = state.inputs
            fetch(LOGIN_PATH, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    username: username,
                    password: password
                })
            })
                .then((res) => {
                    if (res.status === 201) {
                        setUsername(state.inputs.username)
                        dispatch({type: "success"})
                        return undefined
                    }
                    return res.json()
                })
                .then((res) => {
                    if (res) dispatch({ type: "error", message: titleToMessage(res.title) })
                })
                .catch ((err) => dispatch({ type: "error", message: err.message }))
        }
    }

    const { username, password } = state.tag === "editing" ? state.inputs : { username: "", password: "" }
    return (
        <div className="input-box">
            <h1>Login</h1>
            Name: <input name="username" type="text" value={username} onChange={handleChange} />
            <br />
            Password: <input name="password" type="password" value={password} onChange={handleChange} />
            <br />
            {state.tag === 'editing' && state.error && <p>Error: {state.error}</p>}
            {state.tag === 'submitting' && <p>Logging in...</p>}
            <button onClick={handleSubmit}>Login</button>
            <br />
        </div>
    );
}

type State =
    { tag: 'editing'; error?: string, inputs: { username: string, password: string }; } |
    { tag: 'submitting' } |
    { tag: 'redirect' }

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
            break;
        case 'submitting':
            switch (action.type) {
                case "success": return { tag: 'redirect' }
                case "error": return { tag: 'editing', error: action.message, inputs: { username: "", password: "" } }
            }
            break;
        case 'redirect':
            throw new Error("Already in final State 'redirect' and should not reduce to any other State.")
    }
}
