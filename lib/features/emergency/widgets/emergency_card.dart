import 'package:flutter/material.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    super.key,
    required this.title,
    required this.description,
    this.amountDue,
    this.dueDate,
  });
  final String title;
  final String description;
  final String? amountDue;
  final String? dueDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$description : ',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildAmountInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (amountDue != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount Due:', style: TextStyle(fontSize: 16)),
                Text('$amountDue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
          if (dueDate != null) ...[
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Due Date:', style: TextStyle(fontSize: 16)),
                Text('$dueDate', style: TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
