import Medicine from "./medicine.model.js";

export const createMedicine = (data) => {
  return Medicine.create(data);
};

export const getMedicines = (userId) => {
  return Medicine.find({ userId, status: "pending" }).sort({
    isPriority: -1,
    createdAt: -1,
  });
};

export const deleteMedicine = (id, userId) => {
  return Medicine.findOneAndDelete({ _id: id, userId });
};

export const togglePriority = (id, userId) => {
  return Medicine.findOneAndUpdate(
    { _id: id, userId },
    [{ $set: { isPriority: { $not: "$isPriority" } } }],
    { new: true }
  );
};

export const markAsOrdered = (ids, userId) => {
  return Medicine.updateMany(
    { _id: { $in: ids }, userId },
    { status: "ordered" }
  );
};