import 'package:flutter/material.dart';

class PartyTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const PartyTile({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: onTap,
    );
  }
}