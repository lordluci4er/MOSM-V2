import 'package:flutter/material.dart';
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
    return DropdownButton<String>(
      value: selectedId,
      hint: const Text("Select Party"),
      isExpanded: true,
      items: parties.map((p) {
        return DropdownMenuItem(
          value: p.id,
          child: Text(p.name),
        );
      }).toList(),
      onChanged: (val) => onChanged(val!),
    );
  }
}