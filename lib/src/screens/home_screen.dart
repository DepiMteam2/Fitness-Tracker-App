import 'package:flutter/material.dart';
import '/src/widgets/header_home.dart';
import '/src/widgets/progress_card.dart';
import '/src/widgets/goal_card.dart';
import '/src/widgets/daily_task_item.dart';
import '/src/models/goal_model.dart';
import '/src/models/exercise_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Goal> goals = [
      Goal(
        title: 'Body Building',
        image: 'assets/images/body.jpg',
        durationMin: 35,
        calories: 120,
        videoPath: 'assets/videos/bodybuilding.mp4',
      ),
      Goal(
        title: 'Six Pack',
        image: 'assets/images/sixpack.jpg',
        durationMin: 25,
        calories: 100,
        videoPath: 'assets/images/videos/sixpack.mp4',
      ),
    ];

    List<Exercise> tasks = [
      Exercise(
        title: 'Exercise 1',
        image: 'assets/images/ex1.jpg',
        durationMin: 5,
        calories: 120,
      ),
      Exercise(
        title: 'Exercise 2',
        image: 'assets/images/ex2.jpg',
        durationMin: 10,
        calories: 120,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const HeaderWidget(userName: 'Abdo'),
              const SizedBox(height: 16),
              const ProgressCard(progress: 0.25),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Start New Goal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: goals.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => GoalCard(goal: goals[index]),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Task',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...tasks.map((task) => DailyTaskItem(exercise: task)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
