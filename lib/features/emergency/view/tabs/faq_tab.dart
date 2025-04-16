import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/theme/app_theme.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    final faq = context.watch<EmergencyProvider>().faq;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faq?.length ?? 0,
      itemBuilder: (context, index) {
        return FAQItemWidget(
            question: faq?[index].title ?? '', answer: faq?[index].description ?? '');
      },
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
            style: context.theme.textTheme.headlineSmall,
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
