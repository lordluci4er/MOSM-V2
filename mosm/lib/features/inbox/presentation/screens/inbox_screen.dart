import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(title: const Text("Medicine Inbox")),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return MedicineTile(medicine: medicines[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Add Medicine"),
                content: TextField(controller: controller),
                actions: [
                  TextButton(
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}