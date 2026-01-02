import * as React from 'react';
import { MAIN_ADDRESS } from "../auxiliar/Data";
import { AuthContext } from "./AuthProvider";
import {Navigate, useLocation} from "react-router-dom";

const LOGOUT_PATH = MAIN_ADDRESS + '/user/logout';

export function Logout() {
    const location = useLocation()
    const {username, setUsername} = React.useContext(AuthContext);

    function onLogout() {
        fetch(LOGOUT_PATH, { method: 'DELETE' })
            .then(_ => {
                setUsername(undefined);
                goBack();
            })
            .catch(err => console.error(err));
    }

    function goBack() {
        window.history.back(); // TODO: This is not a good way to go back
    }

    if (username) return (
        <div>
            <h1>Are you sure you want to logout?</h1>
            <button onClick={onLogout}>Yes</button>
            <button onClick={goBack}>No</button>
        </div>
    )
    return <Navigate to={location.state?.source || '/'} replace={true} />
}
