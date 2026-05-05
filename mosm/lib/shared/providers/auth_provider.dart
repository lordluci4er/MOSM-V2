import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../core/services/auth_service.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, UserEntity?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<UserEntity?> {
  AuthNotifier() : super(null);

  final repo = AuthRepositoryImpl();
  final authService = AuthService();

  Future<void> login() async {
    final user = await authService.signInWithGoogle();
    if (user == null) return;

    final token = await user.getIdToken();

    if (token == null) {
      throw Exception("Token not found");
    }

    final result = await repo.login(token);
    state = result;
  }

  Future<void> setupShop(
      String name, String phone, String address) async {
    final user = authService.currentUser!;
    final token = await user.getIdToken();

    if (token == null) {
      throw Exception("Token not found");
    }

    final result = await repo.setupShop(token, name, phone, address);
    state = result;
  }
}