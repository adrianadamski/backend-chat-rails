# Ticket nr 5555

## Changelog

### turbo_chatroom
- Secure API hide endpoint
- Make hidden message live disappear
- Send username to Redis

### turbo_chatroom_admin
- Create new Admin user system with login
- Use "message" redis stream to receive messages from turbo_chatroom and display it to the admin
- Use API hide endpoint of "turbo_chatroom" to change message entity state and broadcast Turbo Stream
- Add task app:receive_messages to live broadcast new messages

To connect two apps together I decided to use redis stream because, firstly, I found an implementation of adding new messages to the stream and no usage, so i took it as a tip ;-)
Secondly, using Redis is more suitable than API because of performance, and "turbo_chatroom" doesn't need to know about "turbo_chatroom_admin" existing.