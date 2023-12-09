import User from "../models/userModel.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import generateTokenAndSetCookie from "../utils/helpers/generateTokenAndSetCookie.js";
import mongoose, { mongo } from "mongoose";
import Post from "../models/postModel.js";


const getUserProfile = async (req, res) => {
	// We will fetch user profile either with username or userId
	// query is either username or userId
	const { query } = req.params;

	try {
		let user;
		// query is userId
		if (mongoose.Types.ObjectId.isValid(query)) {
			user = await User.findOne({ _id: query }).select("-password").select("-updatedAt");
		} else {
			// query is username
			user = await User.findOne({ username: query }).select("-password").select("-updatedAt");
		}

		if (!user) return res.status(404).json({ error: "User not found" });

		res.status(200).json(user);
	} catch (err) {
		res.status(500).json({ error: err.message });
		console.log("Error in getUserProfile: ", err.message);
	}
};




const signUpuser = async (req,res) => {
    console.log(req.body);
    //Where the fuck is the body?
    try {
      const {username,name,email,password,img,bio}=req.body;
      //It tries to find if the user exists in the DB by username or
      const user = await User.findOne({$or:[{email},{username}]});

      if(user){
        return res.status(409).json({message: "User already exists"});
      }
    //Basically Salt is the key and we have a 10 sized key and we use it to hash our password and save
    // It in our DB.
    console.log(username)
    //Generating key with Salt.
      const salt = await bcrypt.genSalt(10);
      //Hashing with salt.
      const hashedPassword = await bcrypt.hash(password,salt);
      const newUser = new User({
        name,
        email,
        username,
        password:hashedPassword,

      });
      console.log(User.username)
      await newUser.save();
      if(newUser){
        //Returning the cookie and token
       let token =  generateTokenAndSetCookie(newUser._id,res);
        console.log("Generated Token, moving forward.")
        res.status(201).json({
            _id:newUser._id,
            name: newUser.name,
            email: newUser.email,
            username: newUser.username,
            token: token
        }
            );

      }else{
        res.status(400).json({message: "Invalid User Data"});
      }
    }
    catch(err){
        console.log(req.body)
        res.status(500).json({message: err.message});
        console.log ("Error in Sign Up: ",err.message);
    }
}

const login = async (req,res) =>{
    
    console.log("Login Request received");
    try{
        const {username,password} = req.body;
        const user = await User.findOne({username});
        if(!user){
            return res.status(400).json({message: "Invalid username or password"});

        }
        const isPasswordCorrect = await bcrypt.compare(password,user?.password || " ");

        if(!user || !isPasswordCorrect){
            return res.status(400).json({message: "Invalid username or password"});
        }
        console.log("Generated a Token");
        console.log("User logged in sucessfully");
        res.setHeader('Access-Control-Allow-Credentials', 'true');

       let  token = generateTokenAndSetCookie(user._id,res);
       console.log("Token: ",token);
    console.log(user._id);
        res.status(200).json({
            _id:user._id,
            name: user.name,
            email: user.email,
            username: user.username,
            profilePic: user.profilePic,
            followers: user.followers,
            following: user.following,

        })

    }catch(err){
        res.status(500).json({message: err.message});
        console.log("Error in logIn:  ",err.message);
    }

}

// When logging out we deny the token's verification by adjusting its age to minimum.
const logout = (req,res) => {
    try{
        const token = req.cookies.jwt;
        if(!token){
            //Adjust the Status Code Here.
           return  res.status(404).json({message: "User is not signed in"});
        }
        //It clears the access token and the cookie.
        res.cookie("jwt"," ",{maxAge:1});
        res.status(200).json({message: "User logged out sucessfully"});

    }catch(error){
        res.status(500).json({message: error.message});
        console.log("Error in LogOut:  ",error.message);
    }
}

//In this function we get the user we are handling from the request.
//We get the ID of the user that we are following/unfollowing from prams "link"
//Find both users from the DataBase.
//Read from the UserModel wehther that user is already followed or not and handle accordingly.
//Pull user, by ID, from the followers list to delete and push to add.

const findUser = async(req,res) => {
    try{
        const {username} = req.body;
        const regex =  new RegExp(username,'i');
       //Supposdly here it returns all users that have matching substring
        const users = await User.find({username: {$regex: regex}});

        if(users){
            console.log("Users found: ",users);
            res.status(200).json(users);
        }else{
            return res.status(404).json({message: "User not found"});
        }

    }catch(error){
        console.log("Error in the find user Function: ",error.message);
        return res.status(500).json({message: error.message,});
    }
}

const followunfollowUser = async (req,res) => {
    try {
        const { id } =  req.params; //To read the ID from the url.

        const userToModify = await User.findById(id);

        //This is used to locate the user that made the request.
        const currentuser = await User.findById(req.user._id);
        
        if (id == req.user._id.toString()) return res.status(400).json({message: "You can not follow yourself."});
        if(!userToModify || !currentuser) return res.status(404).json({message: "User not found"});
        console.log(id)
        const isFollowing = currentuser.following.includes(id); //Following is an array in the DB
        //We check if the target id is included in it.
       console.log("Is following?")
        if(isFollowing){
         //Unfollow
         //By removing the IDs from the following of both users.
         //Pull deltes from that object in the DB.
         await User.findByIdAndUpdate(req.user._id, {$pull: {following: id}});
         await User.findByIdAndUpdate(id,{$pull: {followers: req.user._id}});
         console.log("User unfollowed")
         return res.status(200).json({message: "User unfollowed sucessfully"});
        }else{
            //Follow
            //By addinging the IDs to both users.
            //Push adds to it in the DB
            await User.findByIdAndUpdate(req.user._id, {$push: {following: id}});
         await User.findByIdAndUpdate(id,{$push: {followers: req.user._id}});
         console.log("User followed");
        return  res.status(200).json({message: "User followed sucessfully"});

        }


    }
    catch(error){
        res.status(500).json({message: error.message});
        console.log("Error in followunfollow:  ",error.message);
    }

}

const forgotPassword = async(req,res) => {
    console.log("Request was received");
    const {username,email,oldPassword,newPassword} = req.body;
    try{
          if(email==null || oldPassword==null || newPassword==null || username==null){
            return res.status(400).json({message: "Fill are required forms"});
          }

          let user = await User.findOne({email});
          if(!user) return res.status(404).json({message: "Invalid email. User not found"});
          console.log(user)
        //   console.log(user.password);

          const isPasswordCorrect = await bcrypt.compare(oldPassword,user?.password || " ");

          if(!isPasswordCorrect) return res.status(400).json({message: "Password is a mismatch"});
          console.log("PASSWORD IS CORRECT");

          if(newPassword.length < 6) return res.status(400).json({message: "New Password must be atleast 6 characters or more"});

          const isPasswordSimilar = await bcrypt.compare(newPassword,user?.password || " ");
          if(isPasswordSimilar) return res.status(400).json({message: "New password can not be the same as the old password"});

          const salt = await bcrypt.genSalt(10); //Creating the private key.
          const hashedPassword = await bcrypt.hash(newPassword,salt);
          console.log("MOVED ON FROM SALT");

          user.password = hashedPassword;
          console.log("ASsigned it to user.password");
          user = await user.save();
          console.log("IT should've saved it?");
          res.status(200).json({
            _id:user._id,
            name: user.name,
            email: user.email,
            username: user.username,
        })

        //   res.status(200).json({message: "Password was changed sucessfully"});


          

    }catch(error){
        res.status(500).json({message: error.message});
        console.log("Error with the forgotPassword functuniality: ",error.message);
    }

}

const updateUser = async(req,res) => {
    const {name,email,username,password,profilePic,bio} = req.body; //Getting the rest info from the body.
    const userId = req.user._id; //Getting the user ID from the cookie I assume.
    const {id} = req.params; //Where do I get the user ID from though? From the cookie?
    console.log("Request Body: ",req.body);
    try{
      
        let user = await User.findById(userId);

        if(!user) return res.status(400).json({message: "User was not found"});
    
         if(id !== userId.toString()){
            return res.status(400).json({message: "You can not update other profiles"});
         }


        if(password){
            if(password.length<6) return res.status(400).json({message: "Password must be longer than 6 characters"});
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password,salt)
            user.password = hashedPassword;
            //Updating Password.
        }

        if(username||email){
            const foundUser = await User.findOne({$or: [{email},{username}]});
            if(!foundUser){
                user.username = username || user.username;
                user.email = email || user.email;
            } else{
                return res.status(400).json({message: "Username or Email is already in use"});
            }
        }
       
    user.name = name || user.name;
    user.profilePic = profilePic || user.profilePic;
    user.bio = bio || user.bio;

 

    console.log("It should bre returning status Code 200 here");
       user = await user.save();

       res.status(200).json({message: "Profile was updated successfully"});

    }catch(error){
        res.status(500).json({message: error.message});
        console.log(`Error in the updateUser:  ${error.message}`);
    }

}

const getUserPosts =  async(req,res)=>{

    try{
        const {userId} = req.params;
        const posts = await Post.find({postedBy: userId}).sort({createdAt: -1});
        if(posts){
            console.log(posts);
            res.status(200).json(posts);
        }else{

            res.status(404).json({message: "User has not posts"});
        }
    }catch(error){
        res.status(500).json({message: error.message});
        console.log("error in the getUserPosts  ",error.message);
    }

}


const getSuggestedUsers = async (req, res) => {
	try {
		// exclude the current user from suggested users array and exclude users that current user is already following
		const userId = req.user._id;

		const usersFollowedByYou = await User.findById(userId).select("following");

		const users = await User.aggregate([
			{
				$match: {
					_id: { $ne: userId },
				},
			},
			{
				$sample: { size: 10 },
			},
		]);
        
		const filteredUsers = users.filter((user) => !usersFollowedByYou.following.includes(user._id));
		const suggestedUsers = filteredUsers.slice(0, 4);

		suggestedUsers.forEach((user) => (user.password = null));

		res.status(200).json(suggestedUsers);
	} catch (error) {
		res.status(500).json({ error: error.message });
	}
};




export {signUpuser,login,logout, followunfollowUser , updateUser, getUserProfile, forgotPassword, findUser,getUserPosts};