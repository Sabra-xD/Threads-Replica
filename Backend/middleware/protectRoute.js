
import User from "../models/userModel.js";
import jwt from "jsonwebtoken";

const protectRoute = async (req,res,next) =>{
try {
    console.log("Entered the Protected Route!")
    const token = req.cookies.jwt; //Getting the cookie from the request body.

    if(!token) {
        return res.status(401).json({message: "Unauthorized"});
    }

    //We decode the received Jwt token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    
   //Remember that the token contained the userID that was placed in it once the token was created.
   //When we decode, we have the userid so we read it from the decoded message.
    const user = await User.findById(decoded.userId).select("-password");
    //We are going to resend the user with out the password.
    

    // Inside the request object we just received we add the user in it so we can work on him.
    req.user = user;
    console.log("Leaving the ProtectRoute");
    next();
}
catch(error){
    res.status(500).json({message: error.message});
    console.log("Error in ProtectRoute:  ",error.message);

}
}

export default protectRoute;