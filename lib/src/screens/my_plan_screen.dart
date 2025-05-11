import 'package:fitness_app/src/constant/constant.dart';
import 'package:flutter/material.dart';

class MyPlanScreen extends StatelessWidget {

  Widget buildStatCard(String title, String value, String unit, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(44),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Color(0xFF00132D),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),

            ],
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00132D),
                fontFamily: 'Poppins'
            ),
          ),
          Text(
              unit,
              style: TextStyle(
                  color: Color(0xFF959E9F),
                  fontFamily: 'Poppins'
              ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        title: Text(
          'My Plan',
          style: TextStyle(
            fontFamily: 'Poppins'
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Daily Plan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  Spacer(),
                  Text("Statics", style: TextStyle(color: Constant.secondColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                ],
              ),
              SizedBox(height: 20),

              // Daily Plan Cards
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildStatCard("Calories", "720", "Kcal", Colors.orange, Icons.local_fire_department),
                  buildStatCard("Steps", "1000", "Steps", Colors.purple, Icons.directions_walk),
                  buildStatCard("Sleep", "6 hr", "Hours", Colors.green, Icons.nightlight_round),
                  buildStatCard("Water", "2 lits", "Liters", Colors.blue, Icons.water_drop),
                ],
              ),
              SizedBox(height: 20),

              // Goal In Progress
              Text("Goal In Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        'https://images.pexels.com/photos/3837753/pexels-photo-3837753.jpeg?auto=compress',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Body Building", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Full body workout", style: TextStyle(color: Colors.grey[600])),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Chip(
                                label: Text("35 min"),
                                avatar: Icon(Icons.timer, color: Colors.green),
                                backgroundColor: Colors.green.withOpacity(0.1),
                              ),
                              SizedBox(width: 10),
                              Chip(
                                label: Text("120 cal"),
                                avatar: Icon(Icons.local_fire_department, color: Colors.orange),
                                backgroundColor: Colors.orange.withOpacity(0.1),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
