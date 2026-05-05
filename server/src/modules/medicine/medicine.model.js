import mongoose from "mongoose";

const medicineSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },

    name: { type: String, required: true },

    isPriority: {
      type: Boolean,
      default: false,
    },

    status: {
      type: String,
      enum: ["pending", "ordered"],
      default: "pending",
    },
  },
  { timestamps: true }
);

export default mongoose.model("Medicine", medicineSchema);