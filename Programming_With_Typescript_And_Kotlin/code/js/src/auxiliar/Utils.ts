/**
 * Check if the response indicates the user should be logged out.
 * @param res The response to check.
 * @param setUsername A function to set the username.
 * @returns An error message if the response indicates the user should be logged out or undefined otherwise.
 */
export function verifyResponse(res: Response, setUsername: (username: string | undefined) => void) {
    if (res.status === 401 && res.headers.has('WWW-Authenticate')) {
        setUsername(undefined); // Log out the user
        return 'Session expired. Please log in again.'
    }
}
