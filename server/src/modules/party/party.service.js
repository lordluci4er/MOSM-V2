import * as repo from "./party.repository.js";

export const addParty = async (userId, data) => {
  return await repo.createParty({
    ...data,
    userId,
  });
};

export const getParties = async (userId) => {
  return await repo.getAllParties(userId);
};

export const updateParty = async (userId, id, data) => {
  return await repo.updateParty(id, userId, data);
};

export const deleteParty = async (userId, id) => {
  return await repo.deleteParty(id, userId);
};