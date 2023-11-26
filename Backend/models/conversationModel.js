import mongoose, { mongo } from "mongoose";


const conversationSchema = new mongoose.Schema({

    //Basically represents it saves Object ID of the sender and receiver
    participants: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],

    //Saves the ObjectID of the sender.
    lastMessage: {
        text: String,
        sender: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    }

},{timestamps: true});


const Conversation = mongoose.model("Conversation", conversationSchema);

export default Conversation;