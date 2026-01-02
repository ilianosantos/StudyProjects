
import * as React from 'react';
import { Link, Outlet } from 'react-router-dom'
import { JoinPrivateChannel } from "./LeaveOrJoin";

export function Channel(){
    return (
        <div>
            <h1>Channels</h1>
            <ol>
                <li><Link to="public">List all public channels</Link></li>
                <li><Link to="own">List own channels</Link></li>
                <li><Link to="create">Create Channel</Link></li>
                <li><Link to="useInvite">Join Private Channel</Link></li>
            </ol>
            <br/>
            <Outlet />
        </div>
    )
}
