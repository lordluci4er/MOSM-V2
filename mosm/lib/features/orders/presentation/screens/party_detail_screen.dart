import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(title: Text(widget.party.name)),

      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return OrderTile(
                  order: state.orders[index],
                  partyId: widget.party.id,
                );
              },
            ),
    );
  }
}