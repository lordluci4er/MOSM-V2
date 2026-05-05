import express from "express";

/// Module Routes
import authRoutes from "../modules/auth/auth.routes.js";
import partyRoutes from "../modules/party/party.routes.js";
import medicineRoutes from "../modules/medicine/medicine.routes.js";

const router = express.Router();

/// Health Check (useful for testing / uptime monitoring)
router.get("/", (req, res) => {
  res.send("MOSM API is running 🚀");
});

/// Register Routes
router.use("/auth", authRoutes);
router.use("/party", partyRoutes);
router.use("/medicine", medicineRoutes);

export default router;