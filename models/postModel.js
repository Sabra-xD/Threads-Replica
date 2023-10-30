import mongoose from "mongoose";

const postSchema = mongoose.Schema({
    postedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // This sets up a reference to the 'User' model
        required: true,
    },
    text: {
        type: String,
        maxlength: 500, // Corrected "maxLength" spelling
    },
    img: {
        type: String,
    },
    likes: {
        type: Number,
        default: 0,
    },
    replies: [{
        userID: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User', // This sets up a reference to the 'User' model
            required: true,
        },
        text: {
            type: String,
            required: true,
        },
        userProfilePic: {
            type: String,
        },
        userName: {
            type: String,
        }
    }]
}, { timestamps: true });

const Post = mongoose.model("Post", postSchema);

export default Post;
