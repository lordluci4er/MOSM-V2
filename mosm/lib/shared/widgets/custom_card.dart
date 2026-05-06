import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(14),

        /// 🔥 BORDER (SUBTLE)
        border: Border.all(
          color: AppColors.border,
        ),

        /// 🔥 SHADOW (DEPTH)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }
}