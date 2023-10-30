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



export {createPost};