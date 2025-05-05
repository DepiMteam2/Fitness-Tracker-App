import 'package:flutter/material.dart';

import 'height_screen.dart';


class AgeScreen extends StatefulWidget {
  AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  double selectedAge = 20;
  double minAge = 19;
  double maxAge = 22;

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
              SizedBox(height: 40),
              Center(
                child: Text(
                  'HealYou',
                  style: TextStyle(
                    color: Color(0xFF39A2DB),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  'Tell us\nyour age',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedAge.toInt().toString(),
                    style: TextStyle(
                      color: Color(0xFF0D2339),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                children: [
                  _buildAgeMarker(19),
                  _buildAgeMarker(20),
                  _buildAgeMarker(21),
                  _buildAgeMarker(22),
                ],
              ),
              Spacer(),
              _buildNextButton(),
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
        fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeightScreen(),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF39A2DB),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}