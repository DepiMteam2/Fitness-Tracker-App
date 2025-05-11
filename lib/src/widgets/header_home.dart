import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/screens/login_screen.dart';
import 'package:fitness_app/src/screens/profile_screen.dart';
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
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text('Log Out'),
                        onTap: () async {
                          // Show confirmation dialog before logging out
                          bool shouldLogOut = await _showLogOutConfirmation(context);
                          if (shouldLogOut) {
                            await FirebaseAuth.instance.signOut();
                            // Use pushReplacement to ensure the user cannot navigate back
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen())
                            );
                          } else {
                            Navigator.pop(context); // Close the modal if not logging out
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

  Future<bool> _showLogOutConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Don't log out
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Proceed with log out
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    ) ??
        false; // Default value if dialog is dismissed
  }
}
