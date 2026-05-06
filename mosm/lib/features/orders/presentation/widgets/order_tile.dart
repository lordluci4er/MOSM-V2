import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/order_provider.dart';

class OrderTile extends ConsumerWidget {
  final dynamic order;
  final String partyId;

  const OrderTile({
    super.key,
    required this.order,
    required this.partyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

      /// 🔥 MEDICINE NAME
      title: Text(
        order["medicineName"],
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),

      /// 🔥 STATUS TEXT
      subtitle: const Text(
        "Pending",
        style: TextStyle(color: AppColors.grey, fontSize: 12),
      ),

      /// 🔥 ACTION BUTTONS
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ✅ RECEIVED
          GestureDetector(
            onTap: () {
              ref
                  .read(orderProvider.notifier)
                  .markReceived(order["_id"], partyId);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.success,
                size: 18,
              ),
            ),
          ),

          /// ❌ RETURN / NOT RECEIVED
          GestureDetector(
            onTap: () {
              ref
                  .read(orderProvider.notifier)
                  .markReturned(order["_id"], partyId);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.danger,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}