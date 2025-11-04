import 'package:flutter/material.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import '../models/faq_item.dart';
import '../widgets/faq_widget.dart';
import '../widgets/section_title.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      FAQItem(
        question: 'How do I reset my password?',
        answer:
            'Go to the login page and click "Forgot Password". Enter your email and follow the instructions sent to your inbox.',
      ),
      FAQItem(
        question: 'How can I update my profile?',
        answer:
            'Navigate to My Account and click Edit Profile to update your information.',
      ),
      FAQItem(
        question: 'How do I contact support?',
        answer:
            'You can reach our support team via email at support@example.com or call +1-800-SUPPORT.',
      ),
      FAQItem(
        question: 'Is my data secure?',
        answer:
            'Yes, we use industry-standard encryption to protect your personal data.',
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 25),
          const SectionTitle('Frequently Asked Questions'),
          const SizedBox(height: 15),
          ...faqs
              .map(
                (faq) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FAQWidget(item: faq),
                ),
              )
              .toList(),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Contact Support',
                  style: TextStyle(color: AppColors.secondary, fontSize: 25),
                ),
                content: const Text(
                  'Email: support@example.com\nPhone: +1-800-SUPPORT',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close',
                      style: TextStyle(color: AppColors.secondary, fontSize: 16),
                    )
                  ),
                ],
              ),
            ),
            child: const Text(
              'Contact Support',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
