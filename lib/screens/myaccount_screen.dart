import 'package:flutter/material.dart';
import '../widgets/account_info_card.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('My Account', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFEF5350),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const AccountInfoCard(label: 'Full Name', value: 'John Doe'),
          const SizedBox(height: 15),
          const AccountInfoCard(label: 'Email', value: 'john.doe@example.com'),
          const SizedBox(height: 15),
          const AccountInfoCard(label: 'Phone', value: '+1 234 567 8900'),
          const SizedBox(height: 15),
          const AccountInfoCard(label: 'Location', value: 'Cairo, Egypt'),
          const SizedBox(height: 15),
          const AccountInfoCard(label: 'Member Since', value: 'January 2023'),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF5350),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Edit Profile'),
                content: const Text('Profile editing feature coming soon!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
