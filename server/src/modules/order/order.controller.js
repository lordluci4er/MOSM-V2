import * as service from "./order.service.js";

export const createOrder = async (req, res) => {
  try {
    const { partyId, medicines } = req.body;

    const data = await service.createOrder(
      req.user.uid,
      partyId,
      medicines
    );

    res.json({
      success: true,
      data,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getPartyOrders = async (req, res) => {
  try {
    const data = await service.getPartyOrders(
      req.user.uid,
      req.params.partyId
    );

    res.json({
      success: true,
      data,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const received = async (req, res) => {
  try {
    const data = await service.markReceived(
      req.user.uid,
      req.params.id
    );

    res.json({
      success: true,
      data,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const returned = async (req, res) => {
  try {
    const data = await service.markReturned(
      req.user.uid,
      req.params.id
    );

    res.json({
      success: true,
      data,
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};