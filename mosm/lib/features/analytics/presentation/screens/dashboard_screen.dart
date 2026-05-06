import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/analytics_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String filter = "7days";

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(analyticsProvider.notifier).fetchDashboard(filter));
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(analyticsProvider);

    final meds = data["topMedicines"] ?? [];
    final parties = data["topParties"] ?? [];
    final finance = data["finance"] ?? {};

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 FILTER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButton<String>(
                value: filter,
                dropdownColor: AppColors.dark,
                underline: const SizedBox(),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "7days", child: Text("Last 7 Days")),
                  DropdownMenuItem(value: "month", child: Text("This Month")),
                ],
                onChanged: (val) {
                  setState(() => filter = val!);
                  ref
                      .read(analyticsProvider.notifier)
                      .fetchDashboard(val!);
                },
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 SUMMARY CARDS (GRID)
            Row(
              children: [
                Expanded(child: _statCard("Orders", "${data["totalOrders"] ?? 0}", AppColors.primary)),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Due", "₹ ${finance["totalDue"] ?? 0}", AppColors.danger)),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: _statCard("Bill", "₹ ${finance["totalBill"] ?? 0}", AppColors.warning)),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Paid", "₹ ${finance["totalPayment"] ?? 0}", AppColors.success)),
              ],
            ),

            const SizedBox(height: 25),

            /// 🔥 TOP MEDICINES
            _sectionTitle("Top Medicines"),
            const SizedBox(height: 10),

            ...meds.map<Widget>((e) => _listTile(
                  e["_id"],
                  "${e["count"]}",
                )),

            const SizedBox(height: 25),

            /// 🔥 TOP PARTIES
            _sectionTitle("Top Parties"),
            const SizedBox(height: 10),

            ...parties.map<Widget>((e) => _listTile(
                  e["_id"],
                  "${e["count"]}",
                )),
          ],
        ),
      ),
    );
  }

  /// 🔥 STAT CARD (NEW STYLE)
  Widget _statCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  /// 🔥 LIST TILE (UPGRADED)
  Widget _listTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}