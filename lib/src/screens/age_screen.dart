import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:flutter/material.dart';

import 'height_screen.dart';

class AgeScreen extends StatefulWidget {
  AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  double selectedAge = 20;
  final double minAge = 14;
  final double maxAge = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  Constant.appLogoLightMode,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Tell us\nyour age',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                selectedAge.toInt().toString(),
                style: TextStyle(
                  color: Color(0xFF0D2339),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
              SizedBox(height: 40),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 1,
                  activeTrackColor: Color(0xFF1A9CB0),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Color(0xFF1A9CB0),
                  overlayColor: Color(0xFF1A9CB0).withOpacity(0.2),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                ),
                child: Slider(
                  value: selectedAge,
                  min: minAge,
                  max: maxAge,
                  divisions: (maxAge - minAge).toInt(),
                  onChanged: (value) {
                    setState(() {
                      selectedAge = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [14, 22, 32, 42, 50]
                    .map((age) => _buildAgeMarker(age))
                    .toList(),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({
                          'age': selectedAge.toInt(),
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HeightScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User not logged in')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF39A2DB),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgeMarker(int age) {
    bool isSelected = selectedAge.toInt() == age;

    return Text(
      age.toString(),
      style: TextStyle(
        color: isSelected ? Color(0xFF39A2DB) : Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Poppins'
      ),
    );
  }

}
