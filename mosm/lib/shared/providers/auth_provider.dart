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

  final AuthRepositoryImpl repo = AuthRepositoryImpl();
  final AuthService authService = AuthService();

  // =====================================================
  // 🔥 LOGIN
  // =====================================================
  Future<UserEntity?> login() async {
    try {
      final firebaseUser = await authService.signInWithGoogle();
      if (firebaseUser == null) return null;

      final token = await authService.getToken();

      final result = await repo.login(token);

      state = result;

      return result;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return null;
    }
  }

  // =====================================================
  // 🏪 SHOP SETUP
  // =====================================================
  Future<UserEntity?> setupShop(
    String name,
    String phone,
    String address,
  ) async {
    try {
      final token = await authService.getToken();

      final result = await repo.setupShop(
        token,
        name,
        phone,
        address,
      );

      state = result;

      return result;
    } catch (e) {
      print("SETUP ERROR: $e");
      return null;
    }
  }

  // =====================================================
  // 🔄 AUTO LOGIN CHECK
  // =====================================================
  Future<UserEntity?> checkAuth() async {
    try {
      if (!authService.isLoggedIn) return null;

      final token = await authService.getToken();

      final result = await repo.login(token);

      state = result;

      return result;
    } catch (e) {
      print("CHECK AUTH ERROR: $e");
      return null;
    }
  }

  // =====================================================
  // 🚪 LOGOUT
  // =====================================================
  Future<void> logout() async {
    try {
      await authService.logout();
      state = null;
    } catch (e) {
      print("LOGOUT ERROR: $e");
    }
  }

  // =====================================================
  // 🧨 DELETE ACCOUNT
  // =====================================================
  Future<void> deleteAccount() async {
    try {
      await authService.deleteAccount();

      /// 🔥 clear state
      state = null;
    } catch (e) {
      print("DELETE ACCOUNT ERROR: $e");
      rethrow; // 👈 important for UI handling
    }
  }
}