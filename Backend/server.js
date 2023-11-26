import express from "express";
import dotenv from "dotenv";
import connectDB from "./Database/dbconnect.js";
import cookieParser from "cookie-parser";
import userRoutes from "./routes/userRoutes.js"
import postRotues from "./routes/postRoutes.js"
import messageRotues from "./routes/messageRoutes.js"
import { app, server } from "./socket/socket.js";


import cors from "cors";
dotenv.config();


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
app.use(cors(
));

// app.options('*',cors());

// app.enableCors({
//     credentials:true,
//     allowedHeaders:true,
// });
//Get the cookie from the request and resend cookie in response.
app.use(cookieParser());
//Routes
app.use("/api/users",userRoutes);
app.use("/api/posts",postRotues);
app.use("/api/messages", messageRotues);


server.listen( PORT ,() => console.log(`Server Started At Local Host Listening on Port ${PORT}`));