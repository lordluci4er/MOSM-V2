import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalyticsRepositoryImpl {
  final String baseUrl = "http://10.0.2.2:5000/api";

  Future<Map<String, dynamic>> getDashboard(
      String token, String filter) async {
    final res = await http.get(
      Uri.parse("$baseUrl/analytics/dashboard?filter=$filter"),
      headers: {"Authorization": token},
    );

    return jsonDecode(res.body)["data"];
  }
}