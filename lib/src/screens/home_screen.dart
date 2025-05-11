import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:fitness_app/src/screens/kcal_screen.dart';
import 'package:flutter/material.dart';
import '/src/widgets/header_home.dart';
import '/src/widgets/progress_card.dart';
import '/src/widgets/goal_card.dart';
import '/src/widgets/daily_task_item.dart';
import '/src/models/goal_model.dart';
import '/src/models/exercise_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Goal> goals = [
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
      videoPath: 'assets/videos/sixpack.mp4', // تم التصحيح هنا
    ),
  ];

  final List<Exercise> tasks = [
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser!;

  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _checkKcal();
  }

  Future<void> _checkKcal() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docRef = _firestore.collection('users').doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists || doc.data()?['kcal'] == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => KcalScreen()),
        );
      }
    }
  }

  Future<void> _fetchUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          userName = doc.data()?['username'] ?? 'User';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = 'User';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator(color: Constant.secondColor,))
                  : HeaderWidget(userName: userName ?? 'User'),
              SizedBox(height: 35),
              ProgressCard(progress: 0.25),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Goals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Constant.secondColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: goals.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: GoalCard(goal: goals[index]),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Constant.secondColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...tasks.map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DailyTaskItem(exercise: task),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
