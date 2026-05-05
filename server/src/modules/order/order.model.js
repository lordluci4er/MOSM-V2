import mongoose from "mongoose";

const orderSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },

    partyId: { type: mongoose.Schema.Types.ObjectId, ref: "Party" },

    medicineName: { type: String, required: true },

    status: {
      type: String,
      enum: ["ordered", "received", "returned"],
      default: "ordered",
    },
  },
  { timestamps: true }
);

export default mongoose.model("Order", orderSchema);