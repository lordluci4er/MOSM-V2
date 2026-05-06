import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/order_provider.dart';

class OrderTile extends ConsumerWidget {
  final dynamic order;
  final String partyId;

  const OrderTile({
    super.key,
    required this.order,
    required this.partyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(order["medicineName"]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ✅ MARK RECEIVED
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                ref
                    .read(orderProvider.notifier)
                    .markReceived(order["_id"], partyId);
              },
            ),

            /// ❌ MARK RETURNED
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                ref
                    .read(orderProvider.notifier)
                    .markReturned(order["_id"], partyId);
              },
            ),
          ],
        ),
      ),
    );
  }
}