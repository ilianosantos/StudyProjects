import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import { Root } from './Root';
import { Home } from './home/Home';
import { Authors } from './home/Authors';
import { User } from './user/User';
import { Login } from './user/Login';
import { Logout } from './user/Logout';
import { CreateRegistrationInvite } from './user/CreateInvite';
import { Register } from './user/Register';
import { Channel } from './channel/Channel';
import { PublicChannels } from './channel/Public';
import { CreateChannel } from './channel/Create';
import { OwnChannels } from './channel/Own';
import { AuthProvider } from './user/AuthProvider';
import { AuthRequire } from './user/AuthRequire';
import { UseJoinInvite } from './channel/UseJoinInvite';
import { Chat } from "./channel/Chat";

const router = createBrowserRouter([
    {
        path: "/",
        element:
            <AuthProvider>
                <Root />
            </AuthProvider>,
        children: [
            {
                path: "home",
                element: <Home />,
                children: [
                    {
                        path: "authors",
                        element: <Authors />,
                    }
                ]
            },
            {
                path: "users",
                element: <User />,
                children: [
                    {
                        path: "login",
                        element: <Login />
                    },
                    {
                        path: "logout",
                        element:
                            <AuthRequire>
                                <Logout />
                            </AuthRequire>
                    },
                    {
                        path: "register",
                        element:
                            <Register />
                    },
                    {
                        path: "registrationInvite",
                        element:
                            <AuthRequire>
                                <CreateRegistrationInvite />
                            </AuthRequire>
                    }
                ]
            },
            {
                path: "channels",
                element: <Channel />,
                children: [
                    {
                        path: "public",
                        element: <PublicChannels />
                    },
                    {
                        path: "own",
                        element:
                            <AuthRequire>
                                <OwnChannels />
                            </AuthRequire>
                    },
                    {
                        path: "create",
                        element:
                            <AuthRequire>
                                <CreateChannel />
                            </AuthRequire>
                    },
                    {
                        path: "useInvite",
                        element:
                            <AuthRequire>
                                <UseJoinInvite />
                            </AuthRequire>
                    }
                ]
            },
            {
                path: "chat/:channelId",
                element:
                    <AuthRequire>
                        <Chat />
                    </AuthRequire>
            }
        ]
    }
]);

export function renderLayout() {
    createRoot(document.getElementById('App')).render(
        <RouterProvider router={router} future={{ v7_startTransition: true }} />
    );
}
