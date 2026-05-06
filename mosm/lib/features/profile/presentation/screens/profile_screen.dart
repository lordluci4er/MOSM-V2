import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String shopName;
  final String phone;
  final String address;

  const ProfileScreen({
    super.key,
    required this.shopName,
    required this.phone,
    required this.address,
  });

  @override
  ConsumerState<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends ConsumerState<ProfileScreen> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 PROFILE HEADER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color:
                          AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.store,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.shopName,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Medical Store",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _infoCard(
              icon: Icons.phone,
              title: "Phone",
              value: widget.phone,
            ),

            _infoCard(
              icon: Icons.location_on,
              title: "Address",
              value: widget.address,
            ),

            const Spacer(),

            /// 🚪 LOGOUT
            _actionButton(
              text: "Logout",
              color: AppColors.danger,
              onTap: () async {
                await ref
                    .read(authProvider.notifier)
                    .logout();
              },
            ),

            const SizedBox(height: 10),

            /// 🧨 DELETE ACCOUNT
            _actionButton(
              text: isDeleting
                  ? "Deleting..."
                  : "Delete Account",
              color: Colors.red,
              onTap: isDeleting ? null : _confirmDelete,
              isLoading: isDeleting,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // 🔥 CONFIRM DELETE
  // =====================================================
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.dark,
        title: const Text(
          "Delete Account?",
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          "This will permanently delete your account and all data.",
          style: TextStyle(color: AppColors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount();
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // 🧨 DELETE ACCOUNT
  // =====================================================
  Future<void> _deleteAccount() async {
    setState(() => isDeleting = true);

    try {
      await ref
          .read(authProvider.notifier)
          .deleteAccount();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account deleted successfully"),
        ),
      );
    } catch (e) {
      setState(() => isDeleting = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Delete failed: $e"),
        ),
      );
    }
  }

  // =====================================================
  // 🔥 BUTTON
  // =====================================================
  Widget _actionButton({
    required String text,
    required Color color,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  // =====================================================
  // 🔥 INFO CARD
  // =====================================================
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
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
          Icon(icon,
              color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}