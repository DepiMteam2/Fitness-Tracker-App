import 'package:flutter/material.dart';

class SleepHeaderWidget extends StatelessWidget {
  const SleepHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Good Job!',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your Daily Tasks\nAlmost Done!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: const Center(child: Icon(Icons.nightlight_round, size: 50)),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
