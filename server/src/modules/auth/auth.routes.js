import express from "express";
import {
  login,
  setupShop,
  getMe,
  deleteAccount, // 🔥 ADD THIS
} from "./auth.controller.js";

import authMiddleware from "../../core/middlewares/authMiddleware.js";

const router = express.Router();

/// 🔐 AUTH ROUTES
router.post("/login", authMiddleware, login);

/// 🏪 SHOP SETUP
router.post("/setup-shop", authMiddleware, setupShop);

/// 👤 GET USER DATA
router.get("/me", authMiddleware, getMe);

/// 🧨 DELETE ACCOUNT (FULL CLEAN)
router.delete("/delete-account", authMiddleware, deleteAccount);

export default router;