import mongoose from "mongoose";


const messageSchema = new mongoose.Schema({

    
//Refrencing from the Coversation Model
    conversationId: { type: mongoose.Schema.Types.ObjectId, ref: "Conversation" },


    //Refrencing from the User model.
    sender: { type: mongoose.Schema.Types.ObjectId, ref: "User" },


    //Message.
    text: String



},{timestamps: true})

const Message = mongoose.model("Message", messageSchema);
export default Message;
