import 'package:fitness_app/src/constant/constant.dart';
import 'package:fitness_app/src/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuccessRegistrationScreen extends StatefulWidget {
  const SuccessRegistrationScreen({super.key});

  @override
  State<SuccessRegistrationScreen> createState() => _SuccessRegistrationScreenState();
}

class _SuccessRegistrationScreenState extends State<SuccessRegistrationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String? userName;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _controller.forward();

    _fetchUserName();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  ScaleTransition(
                    scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constant.primaryColor.withOpacity(0.1),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 120,
                          color: Color(0xFF25C3F8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? CircularProgressIndicator(color: Constant.secondColor,)
                      : Text(
                    'Welcome, $userName',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'You are all set now, let\'s reach your\ngoals together with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Go To Home',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
