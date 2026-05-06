import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;

  const GoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔥 GOOGLE ICON
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/281/281764.png",
              height: 20,
            ),

            const SizedBox(width: 10),

            /// 🔥 TEXT
            const Text(
              "Continue with Google",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}