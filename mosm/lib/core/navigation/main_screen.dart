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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[currentIndex],
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.dashboard, "Home", 0),
            _navItem(Icons.medical_services, "Inbox", 1),
            _navItem(Icons.shopping_cart, "Orders", 2),
            _navItem(Icons.account_balance_wallet, "Ledger", 3),
            _navItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.white : AppColors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}