import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String token);
  Future<UserEntity> setupShop(
      String token, String name, String phone, String address);
}