import express from "express";
import {signUpuser , login, logout} from "../controllers/userController.js";

const router = express.Router();

router.post("/signup", signUpuser);
router.post("/login", login);
router.post("/logout",logout)

export default router;