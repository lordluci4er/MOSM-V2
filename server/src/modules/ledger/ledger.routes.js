import express from "express";
import authMiddleware from "../../core/middlewares/authMiddleware.js";
import {
  addBill,
  addPayment,
  getLedger,
} from "./ledger.controller.js";

const router = express.Router();

router.use(authMiddleware);

router.post("/bill", addBill);
router.post("/payment", addPayment);
router.get("/:partyId", getLedger);

export default router;