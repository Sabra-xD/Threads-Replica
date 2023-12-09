import express from "express";
import {signUpuser , login, logout , followunfollowUser, updateUser, getUserProfile, forgotPassword, findUser, getUserPosts,getSuggestedUsers} from "../controllers/userController.js";
import protectRoute from "../middleware/protectRoute.js";

const router = express.Router();

router.get("/profile/:query",getUserProfile)
router.post("/signup", signUpuser);
router.post("/login", login);
router.post("/logout",logout);
router.post("/follow/:id",protectRoute,followunfollowUser);
router.post("/updateUser/:id",protectRoute,updateUser)
router.post("/forgotPassword",forgotPassword);
router.post('/finduser',protectRoute,findUser);
router.get("/finduserposts/:userId",getUserPosts);
router.get("/suggested",protectRoute,getSuggestedUsers)



export default router;