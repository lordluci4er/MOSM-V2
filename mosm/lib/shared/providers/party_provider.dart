import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../features/party/data/repositories/party_repository_impl.dart';
import '../../features/party/domain/entities/party_entity.dart';

final partyProvider =
    StateNotifierProvider<PartyNotifier, List<PartyEntity>>((ref) {
  return PartyNotifier();
});

class PartyNotifier extends StateNotifier<List<PartyEntity>> {
  PartyNotifier() : super([]);

  final repo = PartyRepositoryImpl();
  final auth = AuthService();

  /// 📥 Fetch all parties
  Future<void> fetchParties() async {
    try {
      final token = await auth.getToken();
      final data = await repo.getParties(token);
      state = data;
    } catch (e) {
      print("Fetch Parties Error: $e");
    }
  }

  /// ➕ Add new party
  Future<void> addParty(String name, String phone, String address) async {
    try {
      final token = await auth.getToken();
      await repo.addParty(token, name, phone, address);
      await fetchParties();
    } catch (e) {
      print("Add Party Error: $e");
    }
  }

  /// 🗑️ Delete party
  Future<void> deleteParty(String id) async {
    try {
      final token = await auth.getToken();
      await repo.deleteParty(token, id);

      // local state update (fast UI)
      state = state.where((e) => e.id != id).toList();
    } catch (e) {
      print("Delete Party Error: $e");
    }
  }
}