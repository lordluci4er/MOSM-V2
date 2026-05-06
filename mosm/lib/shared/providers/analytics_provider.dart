import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';

final analyticsProvider =
    StateNotifierProvider<AnalyticsNotifier, Map<String, dynamic>>((ref) {
  return AnalyticsNotifier();
});

class AnalyticsNotifier extends StateNotifier<Map<String, dynamic>> {
  AnalyticsNotifier() : super({});

  final repo = AnalyticsRepositoryImpl();
  final auth = AuthService();

  bool isLoading = false;

  Future<void> fetchDashboard(String filter) async {
    try {
      isLoading = true;

      /// ✅ Correct way (NO _auth direct access)
      final token = await auth.getToken();

      final data = await repo.getDashboard(token, filter);

      state = data;
    } catch (e) {
      state = {"error": e.toString()};
    } finally {
      isLoading = false;
    }
  }
}