import * as service from "./medicine.service.js";

export const addMedicine = async (req, res) => {
  try {
    const med = await service.addMedicine(req.user.uid, req.body);

    res.json({
      success: true,
      data: med,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getMedicines = async (req, res) => {
  try {
    const meds = await service.getAllMedicines(req.user.uid);

    res.json({
      success: true,
      data: meds,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const deleteMedicine = async (req, res) => {
  try {
    await service.removeMedicine(req.user.uid, req.params.id);

    res.json({
      success: true,
      message: "Medicine deleted",
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const togglePriority = async (req, res) => {
  try {
    const med = await service.toggleMedicinePriority(
      req.user.uid,
      req.params.id
    );

    res.json({
      success: true,
      data: med,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const moveToOrder = async (req, res) => {
  try {
    await service.moveToOrder(req.user.uid, req.body.ids);

    res.json({
      success: true,
      message: "Moved to order",
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};