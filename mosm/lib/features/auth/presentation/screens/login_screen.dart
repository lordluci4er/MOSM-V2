import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
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
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              /// 🔥 APP TITLE / BRANDING
              const Text(
                "MOSM",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Medical Order & Stock Management",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 40),

              /// 🔥 FEATURE HIGHLIGHT
              _featureTile("Track Orders Easily"),
              _featureTile("Manage Party Ledger"),
              _featureTile("Smart Analytics Dashboard"),

              const Spacer(),

              /// 🔥 LOGIN BUTTON CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Continue with Google",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),

                    GoogleButton(
                      onTap: () async {
                        final result =
                            await ref.read(authProvider.notifier).login();

                        if (result == null) return;

                        if (result.isShopSetup == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DashboardScreen()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ShopSetupScreen()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 FOOTER
              const Text(
                "Secure login powered by Google",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 FEATURE TILE
  Widget _featureTile(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle,
              size: 16, color: AppColors.success),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}