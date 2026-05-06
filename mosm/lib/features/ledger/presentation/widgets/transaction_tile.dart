import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final dynamic tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isBill = tx["type"] == "bill";

    return ListTile(
      title: Text(tx["note"] ?? ""),
      subtitle: Text("₹ ${tx["amount"]}"),
      trailing: Text(
        isBill ? "Bill" : "Payment",
        style: TextStyle(
          color: isBill ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}