import express from "express";

/// Module Routes
import authRoutes from "../modules/auth/auth.routes.js";
import partyRoutes from "../modules/party/party.routes.js";

const router = express.Router();

/// Health Check (optional but useful)
router.get("/", (req, res) => {
  res.send("MOSM API is running 🚀");
});

/// Register Routes
router.use("/auth", authRoutes);
router.use("/party", partyRoutes);

export default router;