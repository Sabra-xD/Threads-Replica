import express from "express";
import { createPost,deletePost,getPost,likeunlikePost } from "../controllers/postController.js";
import protectRoute from "../middleware/protectRoute.js";



const router = express.Router();





router.post("/create",protectRoute,createPost);
router.get("/:id",getPost);
router.delete("/delete/:id",protectRoute,deletePost);
router.post("/like/:id",protectRoute,likeunlikePost);




export default router;