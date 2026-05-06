import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalyticsRepositoryImpl {
  final String baseUrl = "https://mosm-v2.onrender.com/api";

  Future<Map<String, dynamic>> getDashboard(
      String token, String filter) async {
    final res = await http.get(
      Uri.parse("$baseUrl/analytics/dashboard?filter=$filter"),
      headers: {"Authorization": token},
    );

    return jsonDecode(res.body)["data"];
  }
}
