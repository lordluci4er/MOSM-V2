import Ledger from "./ledger.model.js";

export const addEntry = (data) => {
  return Ledger.create(data);
};

export const getPartyLedger = (userId, partyId) => {
  return Ledger.find({ userId, partyId }).sort({ createdAt: -1 });
};

export const getAllLedger = (userId) => {
  return Ledger.find({ userId });
};