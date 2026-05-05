import Party from "./party.model.js";

export const createParty = (data) => {
  return Party.create(data);
};

export const getAllParties = (userId) => {
  return Party.find({ userId }).sort({ createdAt: -1 });
};

export const getPartyById = (id, userId) => {
  return Party.findOne({ _id: id, userId });
};

export const updateParty = (id, userId, data) => {
  return Party.findOneAndUpdate(
    { _id: id, userId },
    data,
    { new: true }
  );
};

export const deleteParty = (id, userId) => {
  return Party.findOneAndDelete({ _id: id, userId });
};