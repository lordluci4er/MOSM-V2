import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../features/analytics/presentation/screens/dashboard_screen.dart';
import '../../features/inbox/presentation/screens/inbox_screen.dart';
import '../../features/orders/presentation/screens/party_orders_screen.dart';
import '../../features/ledger/presentation/screens/ledger_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  /// 🔥 PAGE CONTROLLER
  final PageController _pageController = PageController();

  final screens = [
    const DashboardScreen(),
    const InboxScreen(),
    const PartyOrdersScreen(),
    const LedgerScreen(),
    const ProfileScreen(
      shopName: "My Shop",
      phone: "1234567890",
      address: "Address here",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      /// 🔥 SWIPE NAVIGATION ENABLED
      body: PageView(
        controller: _pageController,

        /// 👇 Smooth iOS-like feel
        physics: const BouncingScrollPhysics(),

        /// 🔥 sync bottom nav
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },

        children: screens,
      ),

      /// 🔥 PREMIUM BOTTOM NAV
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.dashboard_rounded, "Home", 0),
              _navItem(Icons.medical_services_rounded,
                  "Inbox", 1),
              _navItem(Icons.shopping_cart_rounded,
                  "Orders", 2),
              _navItem(Icons.account_balance_wallet_rounded,
                  "Ledger", 3),
              _navItem(Icons.person_rounded, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================================
  /// 🔥 NAV ITEM
  /// =====================================================
  Widget _navItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);

        /// 🔥 PAGE ANIMATION
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,

        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 10,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.transparent,

          borderRadius: BorderRadius.circular(16),

          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.08),
                )
              : null,
        ),

        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),

          child: Row(
            key: ValueKey(isSelected),

            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected
                    ? Colors.white
                    : AppColors.grey,
              ),

              /// 🔥 SHOW LABEL ONLY WHEN ACTIVE
              if (isSelected) ...[
                const SizedBox(width: 8),

                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}