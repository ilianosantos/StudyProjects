import * as React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { MAIN_ADDRESS } from "../auxiliar/Data";

const REGISTER_PATH = MAIN_ADDRESS + '/user/register/'
const HOME_PATH_EXTENSION = '/home'

export function Register() {
    const location = useLocation();
    const [state, dispatch] = React.useReducer(reducer, {
        tag: "editing", inputs: {
            code: "",
            name: "",
            email: "",
            password: ""
        }
    } as State);

    if (state.tag === "redirect") {
        return <Navigate to={location.state?.source || HOME_PATH_EXTENSION} replace={true} />
    }

    function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
        dispatch({ type: "edit", inputName: event.target.name, inputValue: event.target.value })
    }

    function titleToMessage(title: string) {
        switch (title) {
            case "need-not-null-parameters" : return "All fields must be filled!"
            case "password-too-weak" : return "Password too weak!\nMust have 8 to 64 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character!"
            case "invalid-email" : return "Invalid email!"
            case "user-already-exists" : return "User already exists!"
            case "email-already-in-use" : return "Email already in use!"
            case "invalid-registration-invite" : return "Invalid registration code!"
            default: return 'Failed to register!'
        }
    }

    async function handleSubmit() {
        if (state.tag === "editing") {
            dispatch({ type: 'submit' })
            const {code, name, email, password} = state.inputs
            fetch(REGISTER_PATH + code, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    name: name,
                    email: email,
                    password: password
                })
            })
                .then((res) => {
                    if (res.status === 201) {
                        dispatch({type: "success"})
                        return undefined
                    }
                    return res.json()
                })
                .then((res) => {
                    if (res) dispatch({ type: "error", message: titleToMessage(res.title) })
                })
                .catch ((err) => dispatch({ type: 'error', message: err.message }))
        }
    }

    const { code, name, email, password } = state.tag === "editing" ? state.inputs : { code: "", name: "", email: "", password: "" }
    return (
        <div className="input-box">
            <h1>Register</h1>
            Code: <input name="code" value={code} onChange={handleChange} />
            <br />
            Name: <input name="name" value={name} onChange={handleChange} />
            <br />
            Email: <input name="email" value={email} onChange={handleChange} />
            <br />
            Password: <input name="password" type="password" value={password} onChange={handleChange} />
            <br />
            {state.tag === 'editing' && state.message && <p>Error: {state.message}</p>}
            {state.tag === 'submitting' && <p>Registering...</p>}
            <button onClick={handleSubmit}>Register</button>
            <br />
        </div>
    );
}

type State =
    { tag: 'editing'; inputs: {
            code: string,
            name: string,
            email: string,
            password: string
        };
        message?: string } |
    { tag: 'submitting'; inputs: {
            code: string,
            name: string,
            email: string,
            password: string
        }; } |
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
                case "submit": return { tag: 'submitting', inputs: { ...state.inputs } }
            }
            break;
        case 'submitting':
            switch (action.type) {
                case "error": return { tag: 'editing', inputs: { ...state.inputs }, message: action.message }
                case "success": return { tag: 'redirect' }
            }
            break;
        case 'redirect':
            throw new Error("Already in final State 'redirect' and should not reduce to any other State.")
    }
}
