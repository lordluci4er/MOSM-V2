import mongoose from "mongoose";

const partySchema = new mongoose.Schema(
  {
    userId: { type: String, required: true }, // Firebase UID

    name: { type: String, required: true },
    phone: String,
    address: String,

    totalDue: { type: Number, default: 0 },
    totalOrders: { type: Number, default: 0 },

    isFavorite: { type: Boolean, default: false },
  },
  { timestamps: true }
);

export default mongoose.model("Party", partySchema);