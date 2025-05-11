import 'package:flutter/material.dart';

class CaloriesHeader extends StatelessWidget {
  const CaloriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Keep Going!", style: TextStyle(color: Colors.grey)),
        Text(
          "You Have To Eat More Calories!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
