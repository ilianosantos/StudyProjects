import * as React from 'react';

type AuthContextType = {
    username: string | undefined;
    setUsername: (v?: string) => void;
};

export const AuthContext = React.createContext<AuthContextType>({
    username: undefined,
    setUsername: () => {}
});

export function AuthProvider({ children }: { children: React.ReactNode }) {
    const [user, setUser] = React.useState<string | undefined>(() => {
        return localStorage.getItem('username') || undefined;
    });

    const setUsername = (username?: string) => {
        if (username) {
            localStorage.setItem('username', username);
        } else {
            localStorage.removeItem('username');
        }
        setUser(username);
    };

    return (
        <AuthContext.Provider value={{ username: user, setUsername }}>
            {children}
        </AuthContext.Provider>
    );
}
