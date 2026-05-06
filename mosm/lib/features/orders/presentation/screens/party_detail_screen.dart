import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/providers/order_provider.dart';
import '../widgets/order_tile.dart';

class PartyDetailScreen extends ConsumerStatefulWidget {
  final dynamic party;

  const PartyDetailScreen({super.key, required this.party});

  @override
  ConsumerState<PartyDetailScreen> createState() =>
      _PartyDetailScreenState();
}

class _PartyDetailScreenState
    extends ConsumerState<PartyDetailScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(orderProvider.notifier)
          .fetchOrders(widget.party.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: Text(widget.party.name),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state.orders.isEmpty
              ? const Center(
                  child: Text(
                    "No orders yet",
                    style: TextStyle(color: AppColors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.dark,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: OrderTile(
                        order: state.orders[index],
                        partyId: widget.party.id,
                      ),
                    );
                  },
                ),
    );
  }
}