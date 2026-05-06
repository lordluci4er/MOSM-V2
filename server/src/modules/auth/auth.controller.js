import * as service from "./auth.service.js";

/// 🔐 LOGIN
export const login = async (req, res) => {
  try {
    const user = await service.loginUser(req.user);

    res.json({
      success: true,
      data: user,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

/// 🏪 SETUP SHOP
export const setupShop = async (req, res) => {
  try {
    const user = await service.setupShop(req.user.uid, req.body);

    res.json({
      success: true,
      data: user,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

/// 👤 GET USER
export const getMe = async (req, res) => {
  res.json({
    success: true,
    user: req.user,
  });
};

/// 🧨 DELETE ACCOUNT (FIXED)
export const deleteAccount = async (req, res) => {
  try {
    const userId = req.user.uid;

    /// 🔥 FIX: सही service call
    await service.deleteUserData(userId);

    res.json({
      success: true,
      message: "Account deleted successfully",
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};