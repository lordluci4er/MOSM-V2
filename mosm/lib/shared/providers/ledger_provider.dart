import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../features/ledger/data/repositories/ledger_repository_impl.dart';

final ledgerProvider =
    StateNotifierProvider<LedgerNotifier, Map<String, dynamic>>((ref) {
  return LedgerNotifier();
});

class LedgerNotifier extends StateNotifier<Map<String, dynamic>> {
  LedgerNotifier() : super({});

  final repo = LedgerRepositoryImpl();
  final auth = AuthService();

  /// 📊 Fetch Ledger
  Future<void> fetchLedger(String partyId) async {
    final token = await auth.getToken();
    final data = await repo.getLedger(token, partyId);
    state = data;
  }

  /// ➕ Add Bill
  Future<void> addBill(
      String partyId, double amount, String note) async {
    final token = await auth.getToken();
    await repo.addBill(token, partyId, amount, note);

    // Refresh data
    await fetchLedger(partyId);
  }

  /// 💸 Add Payment
  Future<void> addPayment(
      String partyId, double amount, String note) async {
    final token = await auth.getToken();
    await repo.addPayment(token, partyId, amount, note);

    // Refresh data
    await fetchLedger(partyId);
  }
}