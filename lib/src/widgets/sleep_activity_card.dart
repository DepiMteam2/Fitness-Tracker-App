import 'package:fitness_app/src/models/sleep_model.dart';
import 'package:flutter/material.dart';

class SleepActivityCard extends StatelessWidget {
  final SleepModel activity;

  const SleepActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.nightlight_round, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.timeRange, style: const TextStyle(fontSize: 16)),
                Text(
                  'Time: ${activity.duration.inHours}h ${activity.duration.inMinutes % 60}min',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            'Freshness\n${activity.freshness > 0 ? '+' : ''}${activity.freshness}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: activity.freshness >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
