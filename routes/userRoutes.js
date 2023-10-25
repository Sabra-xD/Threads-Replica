import express from "express";
import {signUpuser , login, logout , followunfollowUser} from "../controllers/userController.js";
import protectRoute from "../middleware/protectRoute.js";

const router = express.Router();

router.post("/signup", signUpuser);
router.post("/login", login);
router.post("/logout",logout);
router.post("/follow/:id",protectRoute,followunfollowUser);

export default router;