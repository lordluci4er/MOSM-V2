import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/inbox_provider.dart';
import '../../domain/entities/medicine_entity.dart';

class MedicineTile extends ConsumerWidget {
  final MedicineEntity medicine;

  const MedicineTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

      /// 🔥 MEDICINE NAME
      title: Text(
        medicine.name,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),

      /// 🔥 PRIORITY STAR
      leading: GestureDetector(
        onTap: () {
          ref
              .read(inboxProvider.notifier)
              .togglePriority(medicine.id);
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: medicine.isPriority
                ? AppColors.warning.withOpacity(0.15)
                : AppColors.dark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            medicine.isPriority
                ? Icons.star
                : Icons.star_border,
            color: AppColors.warning,
            size: 18,
          ),
        ),
      ),

      /// 🔥 DELETE BUTTON
      trailing: GestureDetector(
        onTap: () {
          ref
              .read(inboxProvider.notifier)
              .deleteMedicine(medicine.id);
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.danger.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.delete,
            color: AppColors.danger,
            size: 18,
          ),
        ),
      ),
    );
  }
}