import 'package:flutter/material.dart';

class CaloriesProgress extends StatelessWidget {
  final int calories;
  final double progress;

  const CaloriesProgress({
    super.key,
    required this.calories,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: 12,
            backgroundColor: Colors.orange[100],
            valueColor: const AlwaysStoppedAnimation(Colors.orange),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange),
            const SizedBox(height: 4),
            Text(
              '$calories',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Calories'),
          ],
        ),
      ],
    );
  }
}
