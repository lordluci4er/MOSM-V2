import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../features/party/domain/entities/party_entity.dart';

class PartyDropdown extends StatelessWidget {
  final List<PartyEntity> parties;
  final String? selectedId;
  final Function(String) onChanged;

  const PartyDropdown({
    super.key,
    required this.parties,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedId,
          dropdownColor: AppColors.card,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.grey),

          /// 🔥 HINT
          hint: const Text(
            "Select Party",
            style: TextStyle(color: AppColors.grey),
          ),

          /// 🔥 ITEMS
          items: parties.map((p) {
            return DropdownMenuItem(
              value: p.id,
              child: Text(
                p.name,
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }).toList(),

          /// 🔥 ON CHANGE
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }
}