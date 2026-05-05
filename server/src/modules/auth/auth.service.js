import * as repo from "./auth.repository.js";

export const loginUser = async (firebaseUser) => {
  const existingUser = await repo.findUserByUid(firebaseUser.uid);

  if (existingUser) return existingUser;

  const newUser = await repo.createUser({
    uid: firebaseUser.uid,
    name: firebaseUser.name,
    email: firebaseUser.email,
  });

  return newUser;
};

export const setupShop = async (uid, shopData) => {
  return await repo.updateShop(uid, shopData);
};