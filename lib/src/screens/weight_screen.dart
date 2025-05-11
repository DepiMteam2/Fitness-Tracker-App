import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:fitness_app/src/screens/home_screen.dart';
import 'package:fitness_app/src/screens/success_registration_screen.dart';
import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final double minWeight = 30;
  final double maxWeight = 200;
  double selectedWeight = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  Constant.appLogoLightMode,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Tell us\nyour weight',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedWeight.toStringAsFixed(0),
                    style: const TextStyle(
                      color: Color(0xFF0D2339),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'kg',
                    style: TextStyle(
                      color: Color(0xFF0D2339),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 1,
                  activeTrackColor: const Color(0xFF1A9CB0),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: const Color(0xFF1A9CB0),
                  overlayColor: const Color(0xFF1A9CB0).withOpacity(0.2),
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                ),
                child: Slider(
                  value: selectedWeight,
                  min: minWeight,
                  max: maxWeight,
                  divisions: (maxWeight - minWeight).toInt(),
                  onChanged: (value) {
                    setState(() {
                      selectedWeight = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildWeightMarkers(),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: _buildNextButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeightMarkers() {
    List<Widget> markers = [];
    int step = ((maxWeight - minWeight) ~/ 4).toInt();
    for (int i = 0; i <= 4; i++) {
      int weight = (minWeight + step * i).toInt();
      markers.add(_buildWeightMarker(weight));
    }
    return markers;
  }

  Widget _buildWeightMarker(int weight) {
    bool isSelected = selectedWeight.toInt() == weight;
    return Text(
      weight.toString(),
      style: TextStyle(
        color: isSelected ? const Color(0xFF39A2DB) : Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () async {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({
              'weight': selectedWeight,
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SuccessRegistrationScreen()),
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
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF39A2DB),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
