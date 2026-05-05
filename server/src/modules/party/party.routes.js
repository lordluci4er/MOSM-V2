import express from "express";
import authMiddleware from "../../core/middlewares/authMiddleware.js";
import {
  createParty,
  getParties,
  updateParty,
  deleteParty,
} from "./party.controller.js";

const router = express.Router();

router.use(authMiddleware);

router.post("/", createParty);
router.get("/", getParties);
router.put("/:id", updateParty);
router.delete("/:id", deleteParty);

export default router;