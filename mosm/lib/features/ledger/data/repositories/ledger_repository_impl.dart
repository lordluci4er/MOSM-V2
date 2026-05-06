import 'dart:convert';
import 'package:http/http.dart' as http;

class LedgerRepositoryImpl {
  final String baseUrl = "http://10.0.2.2:5000/api";

  Future<dynamic> getLedger(String token, String partyId) async {
    final res = await http.get(
      Uri.parse("$baseUrl/ledger/$partyId"),
      headers: {"Authorization": token},
    );

    return jsonDecode(res.body)["data"];
  }

  Future<void> addBill(
      String token, String partyId, double amount, String note) async {
    await http.post(
      Uri.parse("$baseUrl/ledger/bill"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "partyId": partyId,
        "amount": amount,
        "note": note,
      }),
    );
  }

  Future<void> addPayment(
      String token, String partyId, double amount, String note) async {
    await http.post(
      Uri.parse("$baseUrl/ledger/payment"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "partyId": partyId,
        "amount": amount,
        "note": note,
      }),
    );
  }
}