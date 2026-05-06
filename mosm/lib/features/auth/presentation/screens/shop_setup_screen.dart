import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../analytics/presentation/screens/dashboard_screen.dart';

class ShopSetupScreen extends ConsumerStatefulWidget {
  const ShopSetupScreen({super.key});

  @override
  ConsumerState<ShopSetupScreen> createState() =>
      _ShopSetupScreenState();
}

class _ShopSetupScreenState extends ConsumerState<ShopSetupScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text("Setup Your Shop"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔥 HEADER
              const Text(
                "Let's get started 👋",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Enter your shop details to continue",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 FORM CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _inputField("Shop Name", name),
                    const SizedBox(height: 14),
                    _inputField("Phone Number", phone,
                        keyboard: TextInputType.phone),
                    const SizedBox(height: 14),
                    _inputField("Address", address, maxLines: 2),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result =
                        await ref.read(authProvider.notifier).setupShop(
                              name.text,
                              phone.text,
                              address.text,
                            );

                    if (result != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Setup failed")),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Create My Store",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔥 FOOTER
              const Center(
                child: Text(
                  "Your data is secure and private 🔒",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 CUSTOM INPUT FIELD
  Widget _inputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.grey),
        filled: true,
        fillColor: AppColors.dark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}