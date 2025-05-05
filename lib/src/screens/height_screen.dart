import 'package:flutter/material.dart';
import 'weight_screen.dart';

class HeightScreen extends StatefulWidget {
  HeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double selectedHeight = 5.25;
  double minHeight = 5.1;
  double maxHeight = 5.5;

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
                  'Tell us\nyour height',
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
                    _formatHeight(selectedHeight),
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
                  value: selectedHeight,
                  min: minHeight,
                  max: maxHeight,
                  divisions: ((maxHeight - minHeight) * 10).toInt(),
                  onChanged: (value) {
                    setState(() {
                      selectedHeight = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeightMarker(5.1),
                  _buildHeightMarker(5.2),
                  _buildHeightMarker(5.3),
                  _buildHeightMarker(5.4),
                  _buildHeightMarker(5.5),
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

  String _formatHeight(double height) {
    int feet = height.floor();
    double inches = (height - feet) * 10;
    return "$feet'${inches.round()}";
  }

  Widget _buildHeightMarker(double height, {bool isDefault = false}) {
    bool isSelected = (selectedHeight * 10).round() == (height * 10).round();

    return Text(
      _formatHeight(height),
      style: TextStyle(
        color: isSelected || (isDefault && !isSelected)
            ? Color(0xFF39A2DB)
            : Colors.grey,
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
            builder: (context) => WeightScreen(),
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