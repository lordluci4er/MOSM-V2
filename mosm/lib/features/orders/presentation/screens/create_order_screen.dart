import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
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
    final orderState = ref.watch(orderProvider);
    final loading = orderState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: const Text("Create Order"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: Column(
        children: [
          /// 🔥 PARTY SELECT CARD
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: PartyDropdown(
              parties: parties,
              selectedId: selectedParty,
              onChanged: (val) {
                setState(() => selectedParty = val);
              },
            ),
          ),

          /// 🔥 SELECTED COUNT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Medicines",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "${selectedMedicines.length} selected",
                  style: const TextStyle(color: AppColors.grey),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 MEDICINE LIST
          Expanded(
            child: medicines.isEmpty
                ? const Center(
                    child: Text(
                      "No medicines available",
                      style: TextStyle(color: AppColors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final m = medicines[index];
                      final isSelected =
                          selectedMedicines.contains(m.name);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedMedicines.remove(m.name);
                            } else {
                              selectedMedicines.add(m.name);
                            }
                          });
                        },

                        /// 🔥 MEDICINE CARD
                        child: Container(
                          margin:
                              const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.15)
                                : AppColors.dark,
                            borderRadius:
                                BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              /// 🔥 CHECK ICON
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.card,
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  isSelected
                                      ? Icons.check
                                      : Icons.add,
                                  size: 16,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.grey,
                                ),
                              ),

                              const SizedBox(width: 12),

                              /// 🔥 NAME
                              Expanded(
                                child: Text(
                                  m.name,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          /// 🔥 ORDER BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.black,
              border: Border(
                top: BorderSide(color: AppColors.border),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        if (selectedParty != null &&
                            selectedMedicines.isNotEmpty) {
                          await ref
                              .read(orderProvider.notifier)
                              .createOrder(
                                selectedParty!,
                                selectedMedicines,
                              );

                          await ref
                              .read(inboxProvider.notifier)
                              .fetchMedicines();

                          if (!mounted) return;

                          Navigator.pop(context);
                        }
                      },
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Place Order (${selectedMedicines.length})",
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}