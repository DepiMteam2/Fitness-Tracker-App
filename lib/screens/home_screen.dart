import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9B8FF),
                          borderRadius: BorderRadius.circular(150),
                        ),
                      ),
                      Image.asset(
                        'assets/images/success_registration_image.png',
                        width: 250,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              width: 250,
                              height: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sports_gymnastics, size: 80, color: Colors.deepOrange),
                                  Text("Fitness Illustration", style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Welcome, Stefani',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You are all set now, let\'s reach your\ngoals together with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                },
                child: Text(
                  'Go To Home',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9747FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}