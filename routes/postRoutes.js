import express from "express";
import { createPost,deletePost,getPost } from "../controllers/postController.js";
import protectRoute from "../middleware/protectRoute.js";



const router = express.Router();





router.post("/create",protectRoute,createPost);
router.get("/:id",getPost);
router.post("/delete/:id",protectRoute,deletePost);




export default router;