import express from "express";
import {signUpuser , login, logout , followunfollowUser, updateUser} from "../controllers/userController.js";
import protectRoute from "../middleware/protectRoute.js";

const router = express.Router();

router.post("/signup", signUpuser);
router.post("/login", login);
router.post("/logout",logout);
router.post("/follow/:id",protectRoute,followunfollowUser);
router.post("/updateUser/:id",protectRoute,updateUser)

export default router;