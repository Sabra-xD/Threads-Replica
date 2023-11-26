import jwt from "jsonwebtoken";
const generateTokenAndSetCookie = (userId,res) =>{
 const token = jwt.sign({userId},process.env.JWT_SECRET,
    {
        expiresIn: '15d',
    })

    res.cookie("jwt",token,{
        httpOnly: true,
        //The cookie is not accessible by the browser.
        //Making it more secure.
        maxAge: 15 * 24 * 60 * 60 * 1000,

        sameSite: "strict", //CSRF Attacks?
    });
    return token
}

export default generateTokenAndSetCookie