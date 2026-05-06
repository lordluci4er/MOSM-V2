import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
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
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: const Text("Manage Parties"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      /// 🔥 BODY
      body: parties.isEmpty
          ? const Center(
              child: Text(
                "No parties added",
                style: TextStyle(color: AppColors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: parties.length,
              itemBuilder: (context, index) {
                final p = parties[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      /// 🔥 ICON
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              AppColors.primary.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.business,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// 🔥 NAME + PHONE
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.phone,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 🔥 DELETE BUTTON
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(partyProvider.notifier)
                              .deleteParty(p.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.danger
                                .withOpacity(0.15),
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.danger,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

      /// 🔥 FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddPartyScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}