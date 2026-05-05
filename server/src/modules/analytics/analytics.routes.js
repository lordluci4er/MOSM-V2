import express from "express";
import authMiddleware from "../../core/middlewares/authMiddleware.js";
import { getDashboard } from "./analytics.controller.js";

const router = express.Router();

router.use(authMiddleware);

router.get("/dashboard", getDashboard);

export default router;