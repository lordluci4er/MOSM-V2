import * as repo from "./medicine.repository.js";

export const addMedicine = async (userId, data) => {
  return await repo.createMedicine({
    ...data,
    userId,
  });
};

export const getAllMedicines = async (userId) => {
  return await repo.getMedicines(userId);
};

export const removeMedicine = async (userId, id) => {
  return await repo.deleteMedicine(id, userId);
};

export const toggleMedicinePriority = async (userId, id) => {
  return await repo.togglePriority(id, userId);
};

export const moveToOrder = async (userId, ids) => {
  return await repo.markAsOrdered(ids, userId);
};