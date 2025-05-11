import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'weight_screen.dart';

class HeightScreen extends StatefulWidget {
  HeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double selectedHeight = 5.2;
  final double minHeight = 4.0;
  final double maxHeight = 7.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
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
              const Text(
                'Tell us\nyour height',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _formatHeight(selectedHeight),
                style: const TextStyle(
                  color: Color(0xFF0D2339),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
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
                  value: selectedHeight,
                  min: minHeight,
                  max: maxHeight,
                  divisions: ((maxHeight - minHeight) * 10).toInt(),
                  onChanged: (value) {
                    setState(() {
                      selectedHeight = double.parse(value.toStringAsFixed(1));
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeightMarker(4.0),
                  _buildHeightMarker(4.5),
                  _buildHeightMarker(5.0),
                  _buildHeightMarker(5.5),
                  _buildHeightMarker(6.0),
                  _buildHeightMarker(6.5),
                  _buildHeightMarker(7.0),
                ],
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({
                          'height': selectedHeight,
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WeightScreen()),
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
                    backgroundColor: const Color(0xFF39A2DB),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatHeight(double height) {
    int feet = height.floor();
    int inches = ((height - feet) * 12).round(); // 1 قدم = 12 إنش
    return "$feet'$inches\"";
  }

  Widget _buildHeightMarker(double height) {
    bool isSelected = (selectedHeight * 10).round() == (height * 10).round();
    return Text(
      _formatHeight(height),
      style: TextStyle(
        color: isSelected ? const Color(0xFF39A2DB) : Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    );
  }
}
