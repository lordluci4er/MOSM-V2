import mongoose from "mongoose";

const ledgerSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },
    partyId: { type: mongoose.Schema.Types.ObjectId, ref: "Party" },

    type: {
      type: String,
      enum: ["bill", "payment"],
      required: true,
    },

    amount: { type: Number, required: true },

    note: String,
  },
  { timestamps: true }
);

export default mongoose.model("Ledger", ledgerSchema);