import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class KcalScreen extends StatefulWidget {
  const KcalScreen({super.key});

  @override
  State<KcalScreen> createState() => _KcalScreenState();
}

class _KcalScreenState extends State<KcalScreen> {
  final TextEditingController _kcalController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveKcal() async {
    final user = _auth.currentUser;
    final kcal = _kcalController.text.trim();

    if (user != null && kcal.isNotEmpty) {
      await _firestore.collection('users').doc(user.uid).set({
        'kcal': kcal,
      }, SetOptions(merge: true));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Calories")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kcalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Calories Amount"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveKcal,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
