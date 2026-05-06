import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/order_provider.dart';
import '../../../../shared/providers/party_provider.dart';
import '../../../../shared/providers/inbox_provider.dart';
import '../widgets/party_dropdown.dart';

class CreateOrderScreen extends ConsumerStatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  ConsumerState<CreateOrderScreen> createState() =>
      _CreateOrderScreenState();
}

class _CreateOrderScreenState
    extends ConsumerState<CreateOrderScreen> {
  String? selectedParty;
  List<String> selectedMedicines = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(partyProvider.notifier).fetchParties();
      ref.read(inboxProvider.notifier).fetchMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    final parties = ref.watch(partyProvider);
    final medicines = ref.watch(inboxProvider);

    /// 🔥 IMPORTANT CHANGE
    final orderState = ref.watch(orderProvider);
    final loading = orderState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Create Order")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: PartyDropdown(
              parties: parties,
              selectedId: selectedParty,
              onChanged: (val) {
                setState(() => selectedParty = val);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final m = medicines[index];
                final isSelected =
                    selectedMedicines.contains(m.name);

                return ListTile(
                  title: Text(m.name),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (isSelected) {
                          selectedMedicines.remove(m.name);
                        } else {
                          selectedMedicines.add(m.name);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      /// ✅ FIX 1: proper bool check
                      if (selectedParty != null &&
                          selectedMedicines.isNotEmpty) {
                        await ref
                            .read(orderProvider.notifier)
                            .createOrder(
                              selectedParty!,
                              selectedMedicines,
                            );

                        /// Refresh inbox
                        await ref
                            .read(inboxProvider.notifier)
                            .fetchMedicines();

                        /// ✅ FIX 2: mounted check
                        if (!mounted) return;

                        Navigator.pop(context);
                      }
                    },

              /// UI
              child: loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Place Order"),
            ),
          )
        ],
      ),
    );
  }
}