import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  WeightScreen({Key? key}) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double selectedWeight = 58;
  double minWeight = 56;
  double maxWeight = 60;

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
                  'Tell us\nyour weight',
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
                    selectedWeight.toInt().toString(),
                    style: TextStyle(
                      color: Color(0xFF0D2339),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'kg',
                    style: TextStyle(
                      color: Color(0xFF0D2339),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
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
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildWeightMarker(56),
                  _buildWeightMarker(57),
                  _buildWeightMarker(58),
                  _buildWeightMarker(59),
                  _buildWeightMarker(60),
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

  Widget _buildWeightMarker(int weight, {bool isDefault = false}) {
    bool isSelected = selectedWeight.toInt() == weight;

    return Text(
      weight.toString(),
      style: TextStyle(
        color: isSelected || (isDefault && !isSelected)
            ? Color(0xFF1A9CB0)
            : Colors.grey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile created successfully!'),
            duration: Duration(seconds: 2),
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