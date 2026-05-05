import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/auth_provider.dart';
import 'shop_setup_screen.dart';
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
            await ref.read(authProvider.notifier).login();

            final user = ref.read(authProvider);

            if (user != null) {
              if (user.isShopSetup) {
                // TODO: Navigate to Dashboard later
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ShopSetupScreen()),
                );
              }
            }
          },
        ),
      ),
    );
  }
}