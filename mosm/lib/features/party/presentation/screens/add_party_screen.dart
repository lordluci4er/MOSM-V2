import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/party_provider.dart';

class AddPartyScreen extends ConsumerStatefulWidget {
  const AddPartyScreen({super.key});

  @override
  ConsumerState<AddPartyScreen> createState() =>
      _AddPartyScreenState();
}

class _AddPartyScreenState extends ConsumerState<AddPartyScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Party")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: phone, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: address, decoration: const InputDecoration(labelText: "Address")),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await ref.read(partyProvider.notifier).addParty(
                      name.text,
                      phone.text,
                      address.text,
                    );

                Navigator.pop(context);
              },
              child: const Text("Save Party"),
            )
          ],
        ),
      ),
    );
  }
}