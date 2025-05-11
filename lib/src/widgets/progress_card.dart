import 'package:fitness_app/src/screens/my_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final double progress;
  const ProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPlanScreen())
                  );
                },
                child: Text(
                  'My Plan\nFor Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 7).round()}/7 Complete',
                style: const TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 15.0,
                  percent: progress,
                  backgroundColor: Colors.white24,
                  progressColor: Colors.white,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  animation: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
