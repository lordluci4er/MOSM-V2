import express from "express";
import authMiddleware from "../../core/middlewares/authMiddleware.js";
import {
  createOrder,
  getPartyOrders,
  received,
  returned,
} from "./order.controller.js";

const router = express.Router();

router.use(authMiddleware);

router.post("/", createOrder);
router.get("/:partyId", getPartyOrders);
router.patch("/:id/received", received);
router.patch("/:id/returned", returned);

export default router;