import Post from "../models/postModel.js";
import User from "../models/userModel.js";


const createPost = async (req,res) => {

    try {
        const {postedBy, text, img} = req.body;

        if(!postedBy || !text) return res.status(400).json({message: "Must fill the PostedBy & text fields"});

        const user = await User.findById(postedBy);
        console.log(user)
        //Finding the user 
        if(!user) return res.status(404).json({message: "User not found"});
        
        console.log(user._id.toString());
        console.log(req.user._id.toString()) //We are not getting this, why?
        if(user._id.toString() !== req.user._id.toString()){
          return res.status(401).json({message: "Unauthorized action"});
        }

        const maxLength = 500;
        if(text.length > maxLength){
            return res.status(400).json({message: "You exceeded the number of characters to be used"});

        }

        const newPost = new Post({
            postedBy,
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
      return res.status(200).json({message: "Post was unliked sucessfully."});
    }else{
     //Like the post by adding the user to the likes array.
     post.likes.push(userId);
     await post.save();
     return res.status(200).json({message: "Post was like sucessfully."});

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

// const deleteReply = async(req,res) => {
//     try{
//         const userId = req.user._id;
//         const postId = req.params.id;
//         const replyId = req.params.replyId;

        

        

//         const post = await Post.findOne({_id: postId, 'replies.replyId':replyId});
//         if(!post) return res.status(404).json({message: "Post or reply were not found"});
//         // const reply = post.includes.replies(replyId); //Finding the specific reply using the replyId;
        




        


//     }catch(error){
//         res.status(500).json({message: error.message});
//         console.log("Erorr in the deleteReply function: ",error.message);
//     }
// }



const getFeedPost = async(req,res) => {
    try{
        const userId = req.user._id;
        const user = await User.findById(userId);

        if(!user) return res.status(404).json({message: "User was not found"});

        const following = user.following;
        const feedPosts = await Post.find({postedBy:{$in: following}}).sort({createdAt: -1});


        res.status(200).json(feedPosts);



    }catch(error){
        res.status(500).json({message: error.message});
        console.log("error in the getFeedPost:  ",error.message);
    }
}


export {createPost,getPost,deletePost,likeunlikePost,replyToPost,getFeedPost};