import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(title: const Text("Setup Shop")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Shop Name"),
            ),
            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(labelText: "Address"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final result =
                    await ref.read(authProvider.notifier).setupShop(
                          name.text,
                          phone.text,
                          address.text,
                        );

                /// 🔥 SUCCESS CHECK
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
              child: const Text("Create My Store"),
            )
          ],
        ),
      ),
    );
  }
}