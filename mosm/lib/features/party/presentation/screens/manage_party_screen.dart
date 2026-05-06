import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/party_provider.dart';
import 'add_party_screen.dart';

class ManagePartyScreen extends ConsumerStatefulWidget {
  const ManagePartyScreen({super.key});

  @override
  ConsumerState<ManagePartyScreen> createState() =>
      _ManagePartyScreenState();
}

class _ManagePartyScreenState extends ConsumerState<ManagePartyScreen> {
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
      appBar: AppBar(title: const Text("Parties")),
      body: ListView.builder(
        itemCount: parties.length,
        itemBuilder: (context, index) {
          final p = parties[index];

          return ListTile(
            title: Text(p.name),
            subtitle: Text(p.phone),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(partyProvider.notifier).deleteParty(p.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPartyScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}