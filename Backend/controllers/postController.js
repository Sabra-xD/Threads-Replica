import Post from "../models/postModel.js";
import mongoose, { mongo } from "mongoose";
import User from "../models/userModel.js";
import jwt from "jsonwebtoken";


//So, our current problem is that the cookieis not beign saved, and we check it when sending back to the backend with each protectedrequest.

const createPost = async (req,res) => {

    console.log("Create POST WAS CALLED");

    try {
        const {postedBy, text, img} = req.body;
        console.log("Inside the createPost function");
        console.log("Posted BY: ",postedBy);

        if(!postedBy || !text) return res.status(400).json({message: "Must fill the PostedBy & text fields"});

         
        
        // // const user = await User.findOne({_id: postedBy});
        // const userId = new mongoose.Types.ObjectId(postedBy);
        // const user = await User.findById(userId);

        const decodedToken =  jwt.verify(postedBy, process.env.JWT_SECRET);
    const userId = decodedToken.userId;

    // Convert the user ID to a valid ObjectId
    const userObjectId = new mongoose.Types.ObjectId(userId);



    const user = await User.findById(userObjectId);
        console.log(user)
        //Finding the user 

        if(!user) return res.status(404).json({message: "User not found"});

        console.log("Username: ", user['username']);
        

        const maxLength = 500;
        if(text.length > maxLength){
            return res.status(400).json({message: "You exceeded the number of characters to be used"});

        }

        const newPost = new Post({
            postedBy: userObjectId,
            username: user['username'],
            text,
            img
        });

        await newPost.save();

        return res.status(200).json({message: "Post was created successfully",newPost});







    }catch(error){
        res.status(500).json({message: error.message});
        console.log("Error in the create Post: ",error.message);
    }

};


const getPost = async (req,res) => {
    try{
        const {id} = req.params;//Why though?
        
        const post = await Post.findById(id);

        if(!post) return res.status(404).json({message: "Post was not found"});

        return res.status(200).json({message: "Post was found successfully", post});



    }catch(error){
        res.status(400).json({message: error.message});
        console.log("Error in the getPost: ",error.message);
    }
}


const deletePost = async (req,res) => {
    try{
        const {id} = req.params;
        const post = await Post.findById(id);
        if(!post) return res.status(404).json({message: "Post was not found"});
        //We need to check if the user that is trying to delete this is the same user that has the post.
        console.log(post.postedBy.toString())
        console.log(req.user._id);
        if(post.postedBy.toString()!==req.user._id.toString()){
            return res.status(401).json({message: "Un-Authrized action taken"});
        }

        await Post.findByIdAndDelete(id);

        res.status(200).json({message: "Post was deleted sucessfully"});




        
    }catch(error){
        res.status(400).json({message: error.message});
        console.log("Error in the getPost: ",error.message);
    }

}

const likeunlikePost = async (req,res) => {
  try{
    const {id:postId} = req.params;
    const userId = req.user._id; //Getting the userId from the token.

    const post = await Post.findById(postId);

    if(!post){
        return res.status(404).json({message: "Post was not found"});
    }
    
    const userLike = post.likes.includes(userId); //Checking if the array in the schema of the Post includes this user.

    if(userLike){
      //Unlike the post
      await Post.updateOne({_id:postId},{$pull: {likes: userId}}); //Removing the user from the likes array.
      console.log("Removed from the likes");
      return res.status(200).json({message: "Post was unliked sucessfully."});
    }else{
     //Like the post by adding the user to the likes array.
     post.likes.push(userId);
     await post.save();
     console.log("Added to the likes");
     return res.status(200).json({message: "Post was liked sucessfully."});

    }





  }catch(error){
    res.status(500).json({message: error.message});
    console.log("Error in the likeUnlikeFunction: ",error.message);
  }
}

const replyToPost = async (req, res) => {
    try {
        const { id:postId } = req.params;
        const userId = req.user._id; // Getting userId from the JWT token.
        console.log(userId);
        const post = await Post.findById(postId);
        const { text } = req.body;
        const userProfilePic = req.user.profilePic; // Use 'profilePic' instead of 'ProfilePic'
        const username = req.user.username;

        if (!text) {
            return res.status(400).json({ message: "Text field is required" });
        }

        if (!post) {
            return res.status(404).json({ message: "Post was not found" });
        }

        const reply = {
            userId,
            text,
            username,
            userProfilePic,
        };

        post.replies.push(reply);

        await post.save();

        return res.status(200).json({ message: "Reply was sent successfully" });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

const deleteReply = async (req, res) => {

try{
    const userId = req.user._id;
    const postId = req.params.id;
    const replyId = req.params.replyId;
    
    const user = await User.findById(userId);
    if(!user) res.status(400).json({message: "Action failed: Please login to take this action"});
    const post = await Post.findById(postId);
    if(!post) res.status(404).json({message: "Post was not found"});

    const result = post.replies.find((reply,index) => reply._id.toString() == replyId);

    if(result){
        const reply = result;
        const replyIndex = post.replies.indexOf(reply);
        if(replyIndex == -1) return res.status(404).json({message: "Reply was not found"});
        console.log(reply);
        if(reply.userId.toString() == userId){
            post.replies.splice(replyIndex,1);
            await post.save();
              
            return res.status(200).json({message: "Reply was deleted sucessfully"});
        }
        return res.status(400).json({message: "Unauthrorized Action"});

    }else{
        return res.status(404).json({message: "Reply was not found"});
    }





}catch(error){
    res.status(500).json({message: error.message});
    consloge.log("Error in the deleteReply Function: ",error.message)
}

};
  


const getFeedPost = async(req,res) => {
    try{
        const userId = req.user._id; //We get that from the cookie.
        const user = await User.findById(userId);

        if(!user) return res.status(404).json({message: "User was not found"});

        const following = user.following;
        //Basically what he did there was that he looked into all posts that had the following of the user in them and sorted them and sent them back to the user.
        const feedPosts = await Post.find({postedBy:{$in: following}}).sort({createdAt: -1});
        //Getting the posts made by the following.

       console.log(feedPosts);
       
        res.status(200).json(feedPosts);



    }catch(error){
        res.status(500).json({message: error.message});
        console.log("error in the getFeedPost:  ",error.message);
    }
}




export {createPost,getPost,deletePost,likeunlikePost,replyToPost,getFeedPost,deleteReply};