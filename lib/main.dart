import 'package:fitness_app/constant/constant.dart';
import 'package:fitness_app/screens/congratulations_screen.dart';
import 'package:fitness_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        primaryColor: Constant.primaryColor,
      ),
      home: CongratulationsScreen(),
    );
  }
}
