import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FAQItemWidget(
            question: 'Why is my device locked?',
            answer:
                'Your device is locked due to overdue payment. Once payment is made, your device will be automatically unlocked.'),
        FAQItemWidget(
            question: 'How can I make a payment?',
            answer:
                'You can make a payment using the "Make Payment Now" button on the Alert tab, or contact our support team for assistance.'),
        FAQItemWidget(
            question: 'What happens after I pay?',
            answer:
                'Your device will be automatically unlocked within 24 hours of payment confirmation.'),
        FAQItemWidget(
            question: 'Can I get an extension?',
            answer:
                'Please contact our support team to discuss payment arrangements and possible extensions.'),
      ],
    );
  }
}

class FAQItemWidget extends StatelessWidget {
  const FAQItemWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: context.theme.headlineSmall_F18xW700,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(answer),
            ),
          ],
        ),
      ),
    );
  }
}
