import Order from "./order.model.js";

export const createOrders = (data) => {
  return Order.insertMany(data);
};

export const getOrdersByParty = (userId, partyId) => {
  return Order.find({ userId, partyId, status: "ordered" });
};

export const updateOrderStatus = (id, userId, status) => {
  return Order.findOneAndUpdate(
    { _id: id, userId },
    { status },
    { new: true }
  );
};