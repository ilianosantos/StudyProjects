import * as React from 'react';
import { Outlet, useNavigate } from 'react-router-dom';
import { FaHome } from "react-icons/fa";

export function Root() {
    const navigate = useNavigate()
    return (
        <div className="container">
            <FaHome onClick= {() => navigate("/home")} style={{ cursor: "pointer" }}/>
            <Outlet />
        </div>
    );
}