import * as service from "./analytics.service.js";

export const getDashboard = async (req, res) => {
  try {
    const { filter } = req.query;

    const data = await service.getDashboard(
      req.user.uid,
      filter
    );

    res.json({
      success: true,
      data,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};