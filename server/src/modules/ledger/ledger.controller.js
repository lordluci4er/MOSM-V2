import * as service from "./ledger.service.js";

export const addBill = async (req, res) => {
  try {
    const { partyId, amount, note } = req.body;

    const data = await service.addBill(
      req.user.uid,
      partyId,
      amount,
      note
    );

    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const addPayment = async (req, res) => {
  try {
    const { partyId, amount, note } = req.body;

    const data = await service.addPayment(
      req.user.uid,
      partyId,
      amount,
      note
    );

    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getLedger = async (req, res) => {
  try {
    const data = await service.getLedger(
      req.user.uid,
      req.params.partyId
    );

    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};