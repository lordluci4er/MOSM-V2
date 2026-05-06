import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/inbox_provider.dart';
import '../../domain/entities/medicine_entity.dart';

class MedicineTile extends ConsumerWidget {
  final MedicineEntity medicine;

  const MedicineTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(medicine.name),
      leading: IconButton(
        icon: Icon(
          medicine.isPriority ? Icons.star : Icons.star_border,
          color: Colors.orange,
        ),
        onPressed: () {
          ref
              .read(inboxProvider.notifier)
              .togglePriority(medicine.id);
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          ref
              .read(inboxProvider.notifier)
              .deleteMedicine(medicine.id);
        },
      ),
    );
  }
}