import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:flutter/material.dart';
import 'age_screen.dart';

class GenderSelectionScreen extends StatefulWidget {
  GenderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender;

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
                  'Tell us\nyour gender',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenderOption(
                    gender: 'Male',
                    icon: Icons.male,
                    iconColor: Colors.deepOrange,
                    isSelected: _selectedGender == 'Male',
                    subtext: 'You are planning to use our platform as male?',
                    onTap: () {
                      setState(() {
                        _selectedGender = 'Male';
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  GenderOption(
                    gender: 'Female',
                    icon: Icons.female,
                    iconColor: Colors.purple,
                    isSelected: _selectedGender == 'Female',
                    subtext: 'You are planning to use our platform as female?',
                    onTap: () {
                      setState(() {
                        _selectedGender = 'Female';
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: _selectedGender != null
                      ? () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({
                          'gender': _selectedGender,
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AgeScreen()),
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
                  }
                      : null,
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
}

class GenderOption extends StatelessWidget {
  final String gender;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final String subtext;
  final VoidCallback onTap;

  GenderOption({
    Key? key,
    required this.gender,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.subtext,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? iconColor : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                gender,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  subtext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
              SizedBox(height: 12),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}