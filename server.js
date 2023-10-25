import express from "express";
import dotenv from "dotenv";
import connectDB from "./Database/dbconnect.js";
import cookieParser from "cookie-parser";
import userRoutes from "./routes/userRoutes.js"
dotenv.config();
const app = express();


connectDB();


const PORT = process.env.PORT || 5000;
//Allows us to parse JSON data from the body.
app.use(express.json());
// To Parse data in req.body as well
//But it is nested inside so the single object can be
// Text : {
    // stuff: {}
// }
app.use(express.urlencoded({extended:true}));

//Get the cookie from the request and resend cookie in response.
app.use(cookieParser());
//Routes
app.use("/api/users",userRoutes);


app.listen( PORT , () => console.log(`Server Started At Local Host Listening on Port ${PORT}`));