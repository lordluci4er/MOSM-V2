import Order from "../order/order.model.js";
import Ledger from "../ledger/ledger.model.js";
import Party from "../party/party.model.js";

export const getDashboard = async (userId, filter) => {
  const dateFilter = {};

  if (filter === "7days") {
    dateFilter.createdAt = {
      $gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
    };
  }

  /// 🔥 Top Medicines
  const topMedicines = await Order.aggregate([
    { $match: { userId, ...dateFilter } },
    {
      $group: {
        _id: "$medicineName",
        count: { $sum: 1 },
      },
    },
    { $sort: { count: -1 } },
    { $limit: 5 },
  ]);

  /// 🔥 Top Parties
  const topParties = await Order.aggregate([
    { $match: { userId, ...dateFilter } },
    {
      $group: {
        _id: "$partyId",
        count: { $sum: 1 },
      },
    },
    { $sort: { count: -1 } },
    { $limit: 5 },
  ]);

  /// 🔥 Total Orders
  const totalOrders = await Order.countDocuments({
    userId,
    ...dateFilter,
  });

  /// 🔥 Ledger Summary
  const ledger = await Ledger.find({ userId });

  let totalBill = 0;
  let totalPayment = 0;

  ledger.forEach((l) => {
    if (l.type === "bill") totalBill += l.amount;
    if (l.type === "payment") totalPayment += l.amount;
  });

  const totalDue = totalBill - totalPayment;

  return {
    topMedicines,
    topParties,
    totalOrders,
    finance: {
      totalBill,
      totalPayment,
      totalDue,
    },
  };
};