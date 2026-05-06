import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? text;

  const LoadingWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🔥 LOADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.dark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const SizedBox(
              height: 26,
              width: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// 🔥 OPTIONAL TEXT
          Text(
            text ?? "Loading...",
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}