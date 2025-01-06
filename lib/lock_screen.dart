import 'package:flutter/material.dart';

class LockScreen extends StatelessWidget {
  final String message;

  LockScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Device Locked',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.lock, size: 100, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
