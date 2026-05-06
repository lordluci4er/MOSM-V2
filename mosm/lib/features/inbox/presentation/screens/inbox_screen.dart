import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/inbox_provider.dart';
import '../widgets/medicine_tile.dart';

class InboxScreen extends ConsumerStatefulWidget {
  const InboxScreen({super.key});

  @override
  ConsumerState<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends ConsumerState<InboxScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(inboxProvider.notifier).fetchMedicines());
  }

  @override
  Widget build(BuildContext context) {
    final medicines = ref.watch(inboxProvider);

    return Scaffold(
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: const Text("Medicine Inbox"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      /// 🔥 LIST
      body: medicines.isEmpty
          ? const Center(
              child: Text(
                "No medicines added",
                style: TextStyle(color: AppColors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: MedicineTile(medicine: medicines[index]),
                );
              },
            ),

      /// 🔥 FAB (UPGRADED)
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// 🔥 ADD MEDICINE DIALOG
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: const Text(
            "Add Medicine",
            style: TextStyle(color: AppColors.white),
          ),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: "Enter medicine name",
              hintStyle: const TextStyle(color: AppColors.grey),
              filled: true,
              fillColor: AppColors.dark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(inboxProvider.notifier)
                    .addMedicine(controller.text);

                controller.clear();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }
}