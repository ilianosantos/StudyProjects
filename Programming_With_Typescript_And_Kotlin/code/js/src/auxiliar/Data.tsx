const MAIN_ADDRESS = 'http://localhost:8081/api';

type Message = {
    id: number,
    text: string,
    author: Participant,
    time: string
}
type Participant = {
    id: number,
    user: User,
    channel: Channel,
    type: string,
}
type Channel = {
    id: number,
    name: string,
    owner: User,
    type: string
}
type User = {
    id: number,
    name: string,
    email: string
}
export {
    MAIN_ADDRESS,
    Message,
    Participant,
    Channel,
    User
};
