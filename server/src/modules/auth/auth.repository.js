import User from "./auth.model.js";

export const findUserByUid = (uid) => {
  return User.findOne({ uid });
};

export const createUser = (data) => {
  return User.create(data);
};

export const updateShop = (uid, shopData) => {
  return User.findOneAndUpdate(
    { uid },
    {
      shop: shopData,
      isShopSetup: true,
    },
    { new: true }
  );
};