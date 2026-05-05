import * as repo from "./order.repository.js";
import * as medicineRepo from "../medicine/medicine.repository.js";

export const createOrder = async (userId, partyId, medicines) => {
  const orders = medicines.map((name) => ({
    userId,
    partyId,
    medicineName: name,
  }));

  await medicineRepo.markAsOrdered(
    medicines.map((_, i) => medicines[i]._id),
    userId
  );

  return await repo.createOrders(orders);
};

export const getPartyOrders = async (userId, partyId) => {
  return await repo.getOrdersByParty(userId, partyId);
};

export const markReceived = async (userId, id) => {
  return await repo.updateOrderStatus(id, userId, "received");
};

export const markReturned = async (userId, id) => {
  return await repo.updateOrderStatus(id, userId, "returned");
};