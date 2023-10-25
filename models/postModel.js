import mongoose, { mongo } from "mongoose";


//Something Might Be Wrong here.
//What is ref: "User"?
const postSchema = mongoose.Schema({
    postedBy : {
        //This is Provided by MongoDB, How?
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    text: {
        type: String,
        maxLength: 500,

    },
    img: {
        type: String,
    },
    likes: {
        type: Number,
        default: 0,
    },
    replies: {
        userID: {
            types: mongo.Schema.Types.ObjectId,
            ref: 'User',
            required: true,

        },

        text : {
            type: String,
            required: true,
        },

        userProfilePic: {
            type: String,
            
        },
       userName: {
            type: String,
        }
    },
}, {timestamps: true});

const Post = mongoose.model("Post",postSchema);

export default Post;
