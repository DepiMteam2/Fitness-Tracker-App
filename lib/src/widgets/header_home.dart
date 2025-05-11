import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;

  const HeaderWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning! 👋',
              style: TextStyle(
                  fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
            ),
            Text(
              userName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ],
        ),
        const Spacer(),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.local_fire_department),
                        title: const Text('Edit Kcal Goal'),
                        onTap: () {
                          Navigator.pop(context); // Close bottom sheet first
                          _showEditKcalDialog(context); // Then open dialog
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text('Log Out'),
                        onTap: () async {
                          bool shouldLogOut = await _showLogOutConfirmation(context);
                          if (shouldLogOut) {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          } else {
                            Navigator.pop(context); // Close bottom sheet
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const CircleAvatar(
            child: Icon(Icons.person, size: 28),
          ),
        ),
      ],
    );
  }

  Future<void> _showEditKcalDialog(BuildContext context) async {
    final TextEditingController _kcalController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Kcal Goal'),
        content: TextField(
          controller: _kcalController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter new Kcal value',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final String kcal = _kcalController.text.trim();
              if (kcal.isNotEmpty) {
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({'kcal': int.parse(kcal)});
                }
                Navigator.pop(context); // Close dialog
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showLogOutConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    ) ??
        false;
  }
}