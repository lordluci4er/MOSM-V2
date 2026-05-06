import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
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
      backgroundColor: AppColors.black,

      /// 🔥 APP BAR
      appBar: AppBar(
        title: const Text("Ledger"),
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      /// 🔥 BODY
      body: parties.isEmpty
          ? const Center(
              child: Text(
                "No parties found",
                style: TextStyle(color: AppColors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: parties.length,
              itemBuilder: (context, index) {
                final p = parties[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LedgerDetailScreen(party: p),
                      ),
                    );
                  },

                  /// 🔥 PARTY CARD
                  child: Container(
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
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.business,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// 🔥 NAME
                        Expanded(
                          child: Text(
                            p.name,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        /// 🔥 ARROW
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.grey,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}