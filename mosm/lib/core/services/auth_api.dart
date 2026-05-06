import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  final String baseUrl = "http://10.0.2.2:5000/api";

  Future<Map<String, dynamic>> getMe(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {
        "Authorization": token,
      },
    );

    return jsonDecode(res.body);
  }
}