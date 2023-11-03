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
       type: [mongoose.Schema.Types.ObjectId],
       ref: "User",
       default: []
    },
    replies: [{
        userId: {
            type: mongoose.Schema.Types.ObjectId, //What does this do?
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
