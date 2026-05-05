import * as service from "./auth.service.js";

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

export const getMe = async (req, res) => {
  res.json({
    success: true,
    user: req.user,
  });
};