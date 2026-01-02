import * as React from 'react'
import { Link, Outlet } from 'react-router-dom'
import { AuthContext } from "./AuthProvider";

export function User() {
    const {username} = React.useContext(AuthContext);
    return (
        <div>
            <h1>User</h1>
            <h2>{username ? `Welcome ${username}` : 'Not Logged In'}</h2>
            <ol>{username ?
                (<li><Link to="logout">Logout</Link></li>) :
                (<>
                    <li><Link to="login">Login</Link></li>
                    <li><Link to="register">Register</Link></li>
                </>)}
                <li><Link to="registrationInvite">Create Registration Invite</Link></li>
            </ol>
            <Outlet/>
        </div>
    )
}
