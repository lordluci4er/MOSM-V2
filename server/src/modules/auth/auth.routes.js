import express from "express";
import { login, setupShop, getMe } from "./auth.controller.js";
import authMiddleware from "../../core/middlewares/authMiddleware.js";

const router = express.Router();

router.post("/login", authMiddleware, login);
router.post("/setup-shop", authMiddleware, setupShop);
router.get("/me", authMiddleware, getMe);

export default router;