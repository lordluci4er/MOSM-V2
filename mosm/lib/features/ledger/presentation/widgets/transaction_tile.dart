import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class TransactionTile extends StatelessWidget {
  final dynamic tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isBill = tx["type"] == "bill";

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

      /// 🔥 ICON
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isBill
              ? AppColors.warning.withOpacity(0.15)
              : AppColors.success.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isBill ? Icons.receipt_long : Icons.payments,
          color: isBill ? AppColors.warning : AppColors.success,
          size: 18,
        ),
      ),

      /// 🔥 NOTE
      title: Text(
        tx["note"] ?? "No note",
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),

      /// 🔥 AMOUNT
      subtitle: Text(
        "₹ ${tx["amount"]}",
        style: const TextStyle(color: AppColors.grey),
      ),

      /// 🔥 TYPE TAG
      trailing: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isBill
              ? AppColors.warning.withOpacity(0.15)
              : AppColors.success.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isBill ? "Bill" : "Payment",
          style: TextStyle(
            color: isBill ? AppColors.warning : AppColors.success,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}