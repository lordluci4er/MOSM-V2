import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class PartyTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const PartyTile({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            /// 🔥 ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.business,
                color: AppColors.primary,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            /// 🔥 NAME
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),

            /// 🔥 ARROW
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}