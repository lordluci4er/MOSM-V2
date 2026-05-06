import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/ledger_provider.dart';
import '../widgets/transaction_tile.dart';

class LedgerDetailScreen extends ConsumerStatefulWidget {
  final dynamic party;

  const LedgerDetailScreen({super.key, required this.party});

  @override
  ConsumerState<LedgerDetailScreen> createState() =>
      _LedgerDetailScreenState();
}

class _LedgerDetailScreenState
    extends ConsumerState<LedgerDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(ledgerProvider.notifier)
        .fetchLedger(widget.party.id));
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(ledgerProvider);

    final entries = data["entries"] ?? [];
    final summary = data["summary"] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(widget.party.name)),
      body: Column(
        children: [
          /// SUMMARY 🔥
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Bill: ₹ ${summary["totalBill"] ?? 0}"),
                  Text("Payment: ₹ ${summary["totalPayment"] ?? 0}"),
                  Text(
                    "Due: ₹ ${summary["due"] ?? 0}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return TransactionTile(tx: entries[index]);
              },
            ),
          ),

          /// ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _showDialog(context, true),
                child: const Text("Add Bill"),
              ),
              ElevatedButton(
                onPressed: () => _showDialog(context, false),
                child: const Text("Add Payment"),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, bool isBill) {
    final amount = TextEditingController();
    final note = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(isBill ? "Add Bill" : "Add Payment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: amount, keyboardType: TextInputType.number),
              TextField(controller: note),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final amt = double.tryParse(amount.text) ?? 0;

                if (isBill) {
                  await ref.read(ledgerProvider.notifier).addBill(
                        widget.party.id,
                        amt,
                        note.text,
                      );
                } else {
                  await ref.read(ledgerProvider.notifier).addPayment(
                        widget.party.id,
                        amt,
                        note.text,
                      );
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }
}