import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/party_provider.dart';
import 'party_detail_screen.dart';

class PartyOrdersScreen extends ConsumerStatefulWidget {
  const PartyOrdersScreen({super.key});

  @override
  ConsumerState<PartyOrdersScreen> createState() =>
      _PartyOrdersScreenState();
}

class _PartyOrdersScreenState
    extends ConsumerState<PartyOrdersScreen> {
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
      appBar: AppBar(title: const Text("Party Orders")),
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
                  builder: (_) => PartyDetailScreen(party: p),
                ),
              );
            },
          );
        },
      ),
    );
  }
}