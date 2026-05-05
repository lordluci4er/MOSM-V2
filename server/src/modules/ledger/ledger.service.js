import * as repo from "./ledger.repository.js";

export const addBill = async (userId, partyId, amount, note) => {
  return await repo.addEntry({
    userId,
    partyId,
    type: "bill",
    amount,
    note,
  });
};

export const addPayment = async (userId, partyId, amount, note) => {
  return await repo.addEntry({
    userId,
    partyId,
    type: "payment",
    amount,
    note,
  });
};

export const getLedger = async (userId, partyId) => {
  const data = await repo.getPartyLedger(userId, partyId);

  let totalBill = 0;
  let totalPayment = 0;

  data.forEach((item) => {
    if (item.type === "bill") totalBill += item.amount;
    if (item.type === "payment") totalPayment += item.amount;
  });

  return {
    entries: data,
    summary: {
      totalBill,
      totalPayment,
      due: totalBill - totalPayment,
    },
  };
};