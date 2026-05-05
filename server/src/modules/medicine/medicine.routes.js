import express from "express";
import authMiddleware from "../../core/middlewares/authMiddleware.js";
import {
  addMedicine,
  getMedicines,
  deleteMedicine,
  togglePriority,
  moveToOrder,
} from "./medicine.controller.js";

const router = express.Router();

router.use(authMiddleware);

router.post("/", addMedicine);
router.get("/", getMedicines);
router.delete("/:id", deleteMedicine);
router.patch("/:id/priority", togglePriority);
router.post("/move-to-order", moveToOrder);

export default router;