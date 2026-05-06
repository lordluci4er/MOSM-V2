import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
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
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: Text(widget.party.name),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: Column(
        children: [
          /// 🔥 SUMMARY CARD
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryItem(
                    "Bill", "₹ ${summary["totalBill"] ?? 0}",
                    AppColors.warning),
                _summaryItem(
                    "Paid", "₹ ${summary["totalPayment"] ?? 0}",
                    AppColors.success),
                _summaryItem(
                    "Due", "₹ ${summary["due"] ?? 0}",
                    AppColors.danger),
              ],
            ),
          ),

          /// 🔥 LIST
          Expanded(
            child: entries.isEmpty
                ? const Center(
                    child: Text(
                      "No transactions yet",
                      style: TextStyle(color: AppColors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TransactionTile(tx: entries[index]),
                      );
                    },
                  ),
          ),

          /// 🔥 ACTION BUTTONS
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.black,
              border: Border(
                top: BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                    ),
                    onPressed: () => _showDialog(context, true),
                    child: const Text("Add Bill"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                    onPressed: () => _showDialog(context, false),
                    child: const Text("Add Payment"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 SUMMARY ITEM
  Widget _summaryItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: AppColors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// 🔥 DIALOG (UPGRADED)
  void _showDialog(BuildContext context, bool isBill) {
    final amount = TextEditingController();
    final note = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: Text(
            isBill ? "Add Bill" : "Add Payment",
            style: const TextStyle(color: AppColors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.white),
                decoration: _inputDecoration("Amount"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: note,
                style: const TextStyle(color: AppColors.white),
                decoration: _inputDecoration("Note (optional)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.grey),
              ),
            ),
            ElevatedButton(
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.grey),
      filled: true,
      fillColor: AppColors.dark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
    );
  }
}