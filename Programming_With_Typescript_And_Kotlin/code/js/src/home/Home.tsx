import * as React from 'react';
import { Link, Outlet } from 'react-router-dom';

export function Home() {
    return (
        <div>
            <h1>Welcome to the HomePage</h1>
            <ol>
                <li><Link to="authors">Project Authors</Link></li>
                <li><Link to="/users">Users</Link></li>
                <li><Link to="/channels">Channels</Link></li>
            </ol>
            <Outlet />
        </div>
    );
}
