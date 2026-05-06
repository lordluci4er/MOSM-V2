import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../features/inbox/data/repositories/inbox_repository_impl.dart';
import '../../features/inbox/domain/entities/medicine_entity.dart';

final inboxProvider =
    StateNotifierProvider<InboxNotifier, List<MedicineEntity>>((ref) {
  return InboxNotifier();
});

class InboxNotifier extends StateNotifier<List<MedicineEntity>> {
  InboxNotifier() : super([]);

  final repo = InboxRepositoryImpl();
  final auth = AuthService();

  /// 📥 Fetch Medicines
  Future<void> fetchMedicines() async {
    try {
      final token = await auth.getToken();
      final data = await repo.getMedicines(token);
      state = data;
    } catch (e) {
      print("Fetch Medicines Error: $e");
    }
  }

  /// ➕ Add Medicine
  Future<void> addMedicine(String name) async {
    try {
      final token = await auth.getToken();
      await repo.addMedicine(token, name);
      await fetchMedicines();
    } catch (e) {
      print("Add Medicine Error: $e");
    }
  }

  /// 🗑️ Delete Medicine
  Future<void> deleteMedicine(String id) async {
    try {
      final token = await auth.getToken();
      await repo.deleteMedicine(token, id);

      // Optimistic UI update
      state = state.where((e) => e.id != id).toList();
    } catch (e) {
      print("Delete Medicine Error: $e");
    }
  }

  /// ⭐ Toggle Priority
  Future<void> togglePriority(String id) async {
    try {
      final token = await auth.getToken();
      await repo.togglePriority(token, id);
      await fetchMedicines();
    } catch (e) {
      print("Toggle Priority Error: $e");
    }
  }
}