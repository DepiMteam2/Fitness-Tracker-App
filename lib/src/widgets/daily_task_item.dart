import 'package:flutter/material.dart';
import '/src/models/exercise_model.dart';

class DailyTaskItem extends StatelessWidget {
  final Exercise exercise;
  const DailyTaskItem({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          exercise.image,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        exercise.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.timer, size: 16, color: Colors.green),
          const SizedBox(width: 4),
          Text(
            '${exercise.durationMin} min',
            style: const TextStyle(color: Colors.green),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.local_fire_department,
            size: 16,
            color: Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            '${exercise.calories} cal',
            style: const TextStyle(color: Colors.orange),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.play_circle_fill,
        color: Colors.orange,
        size: 32,
      ),
    );
  }
}
