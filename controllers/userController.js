import User from "../models/userModel.js";
import bcrypt from "bcryptjs";
import generateTokenAndSetCookie from "../utils/helpers/generateTokenAndSetCookie.js";

const signUpuser = async (req,res) => {
    console.log(req.body);
    //Where the fuck is the body?
    try {
      const {username,name,email,password}=req.body;
      //It tries to find if the user exists in the DB by username or
      const user = await User.findOne({$or:[{email},{username}]});

      if(user){
        return res.status(400).json({message: "User already exists"});
      }
    //Basically Salt is the key and we have a 10 sized key and we use it to hash our password and save
    // It in our DB.
    console.log(username)
      const salt = await bcrypt.genSalt(10);
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
        generateTokenAndSetCookie(newUser._id,res);
        console.log("Generated Token, moving forward.")
        res.status(201).json({
            _id:newUser._id,
            name: newUser.name,
            email: newUser.email,
            username: newUser.username,
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
        generateTokenAndSetCookie(user._id,res);

        res.status(200).json({
            _id:user._id,
            name: user.name,
            email: user.email,
            username: user.username,
        })

    }catch(err){
        res.status(500).json({message: errr.message});
        console.log("Error in logIn:  ",error.message);
    }

}

// When logging out we deny the token's verification by adjusting its age to minimum.
const logout = (req,res) => {
    try{
        //It clears the access token and the cookie.
        res.cookie("jwt"," ",{maxAge:1});
        res.status(200).json({message: "User logged out sucessfully"});

    }catch(error){
        res.status(500).json({message: errr.message});
        console.log("Error in LogOut:  ",error.message);
    }
}


const followunfollowUser = async (req,res) => {
    try {
        const { id } =  req.params; //To read the ID from the url.

        const userToModify = await User.findById(id);
        //This is used to locate the user that made the request.
     
        const currentuser = await User.findById(req.user._id);
        
        if (id == req.user._id) return res.status(400).json({message: "You can not follow yourself."});
        if(!userToModify || !currentuser) return res.status(400).json({message: "User not found"});
        console.log(id)
        const isFollowing = currentuser.following.includes(id); //Following is an array in the DB
        //We check if the target id is included in it.
       console.log("Is following?")
        if(isFollowing){
         //Unfollow
         //By removing the IDs from the following of both users.
         //Pull deltes from that object in the DB.
         await User.findByIdAndUpdate(req.user._id, {$pull: {following: id}});
         await User.findByIdAndUpdate(id,{$pull: {following: req.user._id}});
         res.status(200).json({message: "User unfollowed sucessfully"});
        }else{
            //Follow
            //By addinging the IDs to both users.
            //Push adds to it in the DB
            await User.findByIdAndUpdate(req.user._id, {$push: {following: id}});
         await User.findByIdAndUpdate(id,{$push: {following: req.user._id}});
         res.status(200).json({message: "User followed sucessfully"});

        }


    }
    catch(error){
        res.status(500).json({message: error.message});
        console.log("Error in followunfollow:  ",error.message);
    }

}

export {signUpuser,login,logout, followunfollowUser};