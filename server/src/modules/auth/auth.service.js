import * as repo from "./auth.repository.js";
import mongoose from "mongoose";

/// 🔥 IMPORT ALL MODELS (VERY IMPORTANT)
import Party from "../party/party.model.js";
import Order from "../order/order.model.js";
import Medicine from "../medicine/medicine.model.js";
import Transaction from "../ledger/ledger.model.js";
import User from "./auth.model.js";


/// 🔐 LOGIN
export const loginUser = async (firebaseUser) => {
  const existingUser = await repo.findUserByUid(firebaseUser.uid);

  if (existingUser) return existingUser;

  const newUser = await repo.createUser({
    uid: firebaseUser.uid,
    name: firebaseUser.name,
    email: firebaseUser.email,
  });

  return newUser;
};


/// 🏪 SETUP SHOP
export const setupShop = async (uid, shopData) => {
  return await repo.updateShop(uid, shopData);
};


/// 🧨 DELETE ACCOUNT (SAFE VERSION)
export const deleteUserData = async (userId) => {
  const session = await mongoose.startSession();
  session.startTransaction();

  try {
    /// 🔥 DELETE ALL RELATED DATA
    await Party.deleteMany({ userId }).session(session);
    await Order.deleteMany({ userId }).session(session);
    await Medicine.deleteMany({ userId }).session(session);
    await Transaction.deleteMany({ userId }).session(session);

    /// 🔥 DELETE USER
    await User.deleteOne({ uid: userId }).session(session);

    /// ✅ COMMIT
    await session.commitTransaction();
    session.endSession();

    return true;

  } catch (error) {
    /// ❌ ROLLBACK (VERY IMPORTANT)
    await session.abortTransaction();
    session.endSession();

    throw error;
  }
};