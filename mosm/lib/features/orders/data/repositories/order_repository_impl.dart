import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderRepositoryImpl {
  final String baseUrl = "http://10.0.2.2:5000/api";

  /// 🟢 Create Order
  Future<void> createOrder(
      String token, String partyId, List<String> medicines) async {
    final res = await http.post(
      Uri.parse("$baseUrl/order"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "partyId": partyId,
        "medicines": medicines,
      }),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception("Failed to create order");
    }
  }

  /// 📋 Get Orders by Party
  Future<List<dynamic>> getOrders(String token, String partyId) async {
    final res = await http.get(
      Uri.parse("$baseUrl/order/$partyId"),
      headers: {"Authorization": token},
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to fetch orders");
    }

    return jsonDecode(res.body)["data"];
  }

  /// ✅ Mark Received
  Future<void> markReceived(String token, String id) async {
    final res = await http.patch(
      Uri.parse("$baseUrl/order/$id/received"),
      headers: {"Authorization": token},
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to mark received");
    }
  }

  /// ❌ Mark Returned
  Future<void> markReturned(String token, String id) async {
    final res = await http.patch(
      Uri.parse("$baseUrl/order/$id/returned"),
      headers: {"Authorization": token},
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to mark returned");
    }
  }
}