import express from "express";
import {signUpuser , login} from "../controllers/userController.js";

const router = express.Router();

router.post("/signup", signUpuser);
router.post("/login", login);

export default router;