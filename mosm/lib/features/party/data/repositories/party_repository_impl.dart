import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/party_entity.dart';

class PartyRepositoryImpl {
  final String baseUrl = "https://mosm-v2.onrender.com/api";

  Future<List<PartyEntity>> getParties(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/party"),
      headers: {"Authorization": token},
    );

    final data = jsonDecode(res.body)["data"];

    return data.map<PartyEntity>((e) {
      return PartyEntity(
        id: e["_id"],
        name: e["name"],
        phone: e["phone"] ?? "",
        address: e["address"] ?? "",
      );
    }).toList();
  }

  Future<void> addParty(
      String token, String name, String phone, String address) async {
    await http.post(
      Uri.parse("$baseUrl/party"),
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
  }

  Future<void> deleteParty(String token, String id) async {
    await http.delete(
      Uri.parse("$baseUrl/party/$id"),
      headers: {"Authorization": token},
    );
  }
}