
import express from "express"
import { Server } from "socket.io"

const app = express()
app.use(express);

const expressServer = app.listen(3500, ()=> console.log("Express server listening on port 3500"));

const io = new Server(expressServer, {
    cors: {
        origin: "*",
    }
})

io.on('connection', socket => {
    console.log(`User ${socket.id} connected`)

    socket.on('message', data => {
        console.log(data)
        io.emit('message', `${socket.id.substring(0, 5)}: ${data}`)
    })
})

