import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String shopName;
  final String phone;
  final String address;

  const ProfileScreen({
    super.key,
    required this.shopName,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Shop: $shopName"),
            Text("Phone: $phone"),
            Text("Address: $address"),
          ],
        ),
      ),
    );
  }
}