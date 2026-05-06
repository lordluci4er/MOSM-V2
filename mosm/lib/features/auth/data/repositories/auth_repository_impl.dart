import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = "https://mosm-v2.onrender.com/api";

  // =====================================================
  // 🔐 LOGIN
  // =====================================================
  @override
  Future<UserEntity> login(String token) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Authorization": token,
      },
    );

    /// 🔥 STATUS CHECK
    if (res.statusCode != 200) {
      throw Exception("Login failed: ${res.body}");
    }

    final json = jsonDecode(res.body);

    final data = json["data"];

    if (data == null) {
      throw Exception("Invalid response from server");
    }

    return UserEntity(
      uid: data["uid"],
      email: data["email"] ?? "",
      isShopSetup: data["isShopSetup"] ?? false,
    );
  }

  // =====================================================
  // 🏪 SETUP SHOP
  // =====================================================
  @override
  Future<UserEntity> setupShop(
      String token, String name, String phone, String address) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/setup-shop"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "address": address,
      }),
    );

    /// 🔥 STATUS CHECK
    if (res.statusCode != 200) {
      throw Exception("Setup failed: ${res.body}");
    }

    final json = jsonDecode(res.body);

    final data = json["data"];

    if (data == null) {
      throw Exception("Invalid response from server");
    }

    return UserEntity(
      uid: data["uid"],
      email: data["email"] ?? "",
      isShopSetup: true,
    );
  }
}