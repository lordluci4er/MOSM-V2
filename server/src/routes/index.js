import express from "express";

/// Module Routes
import authRoutes from "../modules/auth/auth.routes.js";
import partyRoutes from "../modules/party/party.routes.js";
import medicineRoutes from "../modules/medicine/medicine.routes.js";
import orderRoutes from "../modules/order/order.routes.js";
import ledgerRoutes from "../modules/ledger/ledger.routes.js";
import analyticsRoutes from "../modules/analytics/analytics.routes.js";

const router = express.Router();

/// 🟢 Health Check (for uptime / testing)
router.get("/", (req, res) => {
  res.send("MOSM API is running 🚀");
});

/// 🔐 Auth Routes
router.use("/auth", authRoutes);

/// 🏢 Party Routes
router.use("/party", partyRoutes);

/// 💊 Medicine Inbox Routes
router.use("/medicine", medicineRoutes);

/// 📦 Order Routes
router.use("/order", orderRoutes);

/// 💰 Ledger Routes
router.use("/ledger", ledgerRoutes);

/// 📊 Analytics Routes
router.use("/analytics", analyticsRoutes);

export default router;