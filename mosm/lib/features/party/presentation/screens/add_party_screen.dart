import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/party_provider.dart';

class AddPartyScreen extends ConsumerStatefulWidget {
  const AddPartyScreen({super.key});

  @override
  ConsumerState<AddPartyScreen> createState() =>
      _AddPartyScreenState();
}

class _AddPartyScreenState extends ConsumerState<AddPartyScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: const Text("Add Party"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 HEADER
            const Text(
              "Add New Party",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Enter supplier details",
              style: TextStyle(color: AppColors.grey, fontSize: 13),
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
                  _inputField("Party Name", name),
                  const SizedBox(height: 14),
                  _inputField("Phone Number", phone,
                      keyboard: TextInputType.phone),
                  const SizedBox(height: 14),
                  _inputField("Address", address, maxLines: 2),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 🔥 SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(partyProvider.notifier).addParty(
                        name.text,
                        phone.text,
                        address.text,
                      );

                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text("Save Party"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 INPUT FIELD
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