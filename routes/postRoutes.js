import express from "express";
import { createPost,deletePost,getFeedPost,getPost,likeunlikePost,replyToPost,deleteReply } from "../controllers/postController.js";
import protectRoute from "../middleware/protectRoute.js";



const router = express.Router();




router.get("/feed",protectRoute,getFeedPost);
router.post("/create",protectRoute,createPost);
router.get("/:id",getPost);
router.delete("/delete/:id",protectRoute,deletePost);
router.post("/like/:id",protectRoute,likeunlikePost);
router.post("/reply/:id",protectRoute,replyToPost);
router.delete("/reply/:id/:replyId",protectRoute,deleteReply);




export default router;