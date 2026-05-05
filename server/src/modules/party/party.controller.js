import * as service from "./party.service.js";

export const createParty = async (req, res) => {
  try {
    const party = await service.addParty(req.user.uid, req.body);

    res.json({
      success: true,
      data: party,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getParties = async (req, res) => {
  try {
    const parties = await service.getParties(req.user.uid);

    res.json({
      success: true,
      data: parties,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const updateParty = async (req, res) => {
  try {
    const party = await service.updateParty(
      req.user.uid,
      req.params.id,
      req.body
    );

    res.json({
      success: true,
      data: party,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const deleteParty = async (req, res) => {
  try {
    await service.deleteParty(req.user.uid, req.params.id);

    res.json({
      success: true,
      message: "Party deleted",
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};