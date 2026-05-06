import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/party_provider.dart';
import 'ledger_detail_screen.dart';

class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen({super.key});

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(partyProvider.notifier).fetchParties());
  }

  @override
  Widget build(BuildContext context) {
    final parties = ref.watch(partyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Ledger")),
      body: ListView.builder(
        itemCount: parties.length,
        itemBuilder: (context, index) {
          final p = parties[index];

          return ListTile(
            title: Text(p.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LedgerDetailScreen(party: p),
                ),
              );
            },
          );
        },
      ),
    );
  }
}