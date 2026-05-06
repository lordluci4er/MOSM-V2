import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/medicine_entity.dart';

class InboxRepositoryImpl {
  final String baseUrl = "https://mosm-v2.onrender.com/api";

  Future<List<MedicineEntity>> getMedicines(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/medicine"),
      headers: {"Authorization": token},
    );

    final data = jsonDecode(res.body)["data"];

    return data.map<MedicineEntity>((e) {
      return MedicineEntity(
        id: e["_id"],
        name: e["name"],
        isPriority: e["isPriority"],
      );
    }).toList();
  }

  Future<void> addMedicine(String token, String name) async {
    await http.post(
      Uri.parse("$baseUrl/medicine"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name}),
    );
  }

  Future<void> deleteMedicine(String token, String id) async {
    await http.delete(
      Uri.parse("$baseUrl/medicine/$id"),
      headers: {"Authorization": token},
    );
  }

  Future<void> togglePriority(String token, String id) async {
    await http.patch(
      Uri.parse("$baseUrl/medicine/$id/priority"),
      headers: {"Authorization": token},
    );
  }
}