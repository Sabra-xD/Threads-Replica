import express from "express";
import { createPost,getPost } from "../controllers/postController.js";
import protectRoute from "../middleware/protectRoute.js";



const router = express.Router();





router.post("/create",protectRoute,createPost);
router.get("/:id",getPost);





export default router;