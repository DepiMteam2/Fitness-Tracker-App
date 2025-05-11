import 'package:flutter/material.dart';
import '/src/models/exercise_model.dart';

class DailyTaskItem extends StatelessWidget {
  final Exercise exercise;
  const DailyTaskItem({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              exercise.image,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1D1D1D),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      '${exercise.durationMin} min',
                      style: const TextStyle(color: Colors.green, fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.local_fire_department,
                        size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${exercise.calories} cal',
                      style:
                      const TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 2),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.orange,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
