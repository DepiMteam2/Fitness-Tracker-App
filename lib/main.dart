import 'package:fitness_app/constant/constant.dart';
import 'package:fitness_app/screens/login_screen.dart';
import 'package:fitness_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: LoginScreen(),
    );
  }
}
