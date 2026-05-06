import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/auth_provider.dart';
import 'shop_setup_screen.dart';
import '../../../analytics/presentation/screens/dashboard_screen.dart';
import '../widgets/google_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: GoogleButton(
          onTap: () async {
            /// 🔥 LOGIN + BACKEND CHECK (FINAL FIX)
            final result =
                await ref.read(authProvider.notifier).login();

            if (result == null) return;

            /// result = backend user data
            if (result.isShopSetup == true) {
              /// ✅ DIRECT DASHBOARD
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const DashboardScreen()),
              );
            } else {
              /// ✅ FIRST TIME USER
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const ShopSetupScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}