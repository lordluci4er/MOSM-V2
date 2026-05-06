import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = "https://mosm-v2.onrender.com/api"; // Android emulator

  @override
  Future<UserEntity> login(String token) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Authorization": token},
    );

    final data = jsonDecode(res.body);

    return UserEntity(
      uid: data["data"]["uid"],
      email: data["data"]["email"] ?? "",
      isShopSetup: data["data"]["isShopSetup"] ?? false,
    );
  }

  @override
  Future<UserEntity> setupShop(
      String token, String name, String phone, String address) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/setup-shop"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "address": address,
      }),
    );

    final data = jsonDecode(res.body);

    return UserEntity(
      uid: data["data"]["uid"],
      email: data["data"]["email"] ?? "",
      isShopSetup: true,
    );
  }
}