import { text } from "express";
import Conversation from "../models/conversationModel.js";
import Message
 from "../models/messageModel.js";


async function sendMessage(req,res){

    try{
        const {recipientId, message} = req.body;
        const senderId = req.user._id;
        //Find the conversation that has both the sender and recepient ids.
        let conversation = await Conversation.findOne({participants: {$all: [senderId,recipientId]}});
        

        if(!conversation){
            conversation = new Conversation({
                participants: [senderId,recipientId],
                lastMessage: {
                    text: message,
                    sender: senderId,

                }
            });
            await conversation.save();
        }

        const newMessage = new Message({
conversationId: conversation._id,
sender: senderId,
text: message
        });

        await Promise.all([
            newMessage.save(),
            conversation.updateOne({
                lastMessage: {
                    text: message,
                    sender: senderId,
                }
            }),
        ]);

        res.status(201).json(newMessage);

    }catch(error){
        console.log("Error in the sendMessage: ",error.message);
        res.status(500).json({message: `Error in the sendMessage: ${error.message}`});
    }
}


async function getMessages(req,res){
    const { otherUserId } = req.params;
    const userId = req.user._id;
    try{
        //Get the conversation that has participants of
        //UserId and otherUserId


        const conversation = await Conversation.findOne({participants: {$all: [userId,otherUserId]}});
        if(!conversation) return res.status(404).json({message: "Conversation was not found"});

        const messages = await Message.find({
            conversationId: conversation._id,

        }).sort({createdAt: 1});

        console.log("The messages: ",messages);
        res.status(200).json(messages);



    }catch(error){
        console.log("Error in the getMessages: ",error.message);
        res.status(500).json({message: `Error in the getMessages: ${error.message}`});
    }
}


 async function getConversations(req,res) {
    const userId = req.user._id; //Getting userId from the cookie.

    try{
        //What does this do in reality?
        //Basically it should fill the participants array with each user's username and profilePic
        //Instead of having to use getUserProfile.

        const conversations = await Conversation.find({participants: userId}).populate({
            path: "participants",
            select: "username profilePic",
        });

        res.status(200).json(conversations);

    }catch(error){
        console.log("Error in the getConversation: ",error.message);
        res.status(500).json({message: error.message});
    }
 }


 export { sendMessage, getMessages, getConversations }