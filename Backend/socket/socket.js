import {Server} from "socket.io";
import http from "http";
import express from "express";
import Message from "../models/messageModel.js";
import Conversation from "../models/conversationModel.js";




const app = express();
const server = http.createServer(app);
const io = new Server(server, {
	cors: {
		origin: "*",
		methods: ["GET", "POST"],
	},
});

export const getRecipientSocketId = (recipientId) => {
	return userSocketMap[recipientId];
};

const userSocketMap = {}; // userId: socketId

io.on("connection", (socket) => {

	console.log("user connected", socket.id);
    //Get the userId from the socket handshake. So we need to send the userID in it.
    socket.on('msg', ()=>{
        console.log("First message received from the FE");
    })


	const userId = socket.handshake.query.userId;

     //Adding the user to our hasMap of userSocketMap and linking it to his socket.id

	if (userId != "undefined") userSocketMap[userId] = socket.id;

    //Sends the userIds of all online users to the FrontEnd
    //We receive it through io.on('getOnlineUsers').
	io.emit("getOnlineUsers", Object.keys(userSocketMap));


    //Listens for incoming traffic under the key of "markMessageAsSeen"
    //We use socket.on because we are dealing with events between the server and a specific client.
	socket.on("markMessagesAsSeen", async ({ conversationId, userId }) => {
		try {
			await Message.updateMany({ conversationId: conversationId, seen: false }, { $set: { seen: true } });
			await Conversation.updateOne({ _id: conversationId }, { $set: { "lastMessage.seen": true } });
			io.to(userSocketMap[userId]).emit("messagesSeen", { conversationId });
		} catch (error) {
			console.log(error);
		}
	});

    //Disconnecting a single client. So we only listen for the "disconnected" on a specific socket.
    //This is specific for an individual socket.
	socket.on("disconnect", () => {
		console.log("user disconnected");
		delete userSocketMap[userId];
		io.emit("getOnlineUsers", Object.keys(userSocketMap));
	});
});

export { io, server, app };