import express from "express";
import {signUpuser , login, logout , followunfollowUser, updateUser, getUserProfile, forgotPassword, getUserByID} from "../controllers/userController.js";
import protectRoute from "../middleware/protectRoute.js";

const router = express.Router();

router.get("/profile/:username",getUserProfile)
router.post("/signup", signUpuser);
router.post("/login", login);
router.post("/logout",logout);
router.post("/follow/:id",protectRoute,followunfollowUser);
router.post("/updateUser/:id",protectRoute,updateUser)
router.post("/forgotPassword",forgotPassword);
router.post("/userbyid", getUserByID);



export default router;