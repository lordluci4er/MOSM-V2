import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(title: const Text("Dashboard")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// FILTER
            DropdownButton<String>(
              value: filter,
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

            const SizedBox(height: 10),

            /// TOTAL ORDERS
            _card("Total Orders", "${data["totalOrders"] ?? 0}"),

            /// FINANCE
            _card("Total Bill", "₹ ${finance["totalBill"] ?? 0}"),
            _card("Total Payment", "₹ ${finance["totalPayment"] ?? 0}"),
            _card("Total Due", "₹ ${finance["totalDue"] ?? 0}"),

            const SizedBox(height: 20),

            /// TOP MEDICINES
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Top Medicines")),
            ...meds.map<Widget>((e) => ListTile(
                  title: Text(e["_id"]),
                  trailing: Text("${e["count"]}"),
                )),

            const SizedBox(height: 20),

            /// TOP PARTIES
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Top Parties")),
            ...parties.map<Widget>((e) => ListTile(
                  title: Text(e["_id"]),
                  trailing: Text("${e["count"]}"),
                )),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}