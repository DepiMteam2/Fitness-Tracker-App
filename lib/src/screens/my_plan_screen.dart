import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/src/classes/kcal_burn_suggestion.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:flutter/material.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({super.key});

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  Map<String, dynamic>? suggestions;

  @override
  void initState() {
    super.initState();
    fetchKcalData();
  }

  Future<void> fetchKcalData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final kcalValue = doc.data()?['kcal'];

      if (kcalValue != null) {
        final kcal = double.tryParse(kcalValue.toString()) ?? 0;
        final result = KcalBurnSuggestion(targetKcal: kcal).getSuggestionsSummary();

        setState(() {
          suggestions = result;
        });
      }
    }
  }

  Widget buildStatCard(String title, String value, String unit, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
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
                  style: const TextStyle(
                      color: Color(0xFF00132D),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00132D),
                fontFamily: 'Poppins'),
          ),
          Text(
            unit,
            style: const TextStyle(color: Color(0xFF959E9F), fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: suggestions == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFAFAFA),
            pinned: true,
            centerTitle: true,
            title: const Text('My Plan', style: TextStyle(fontFamily: 'Poppins')),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Text("Daily Plan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  const Spacer(),
                  Text("Statics", style: TextStyle(color: Constant.secondColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                buildStatCard("Calories", '${suggestions!['kcal']}', "Kcal", Colors.orange, Icons.local_fire_department),
                buildStatCard("Steps", suggestions!['walk_km'], "Km", Colors.purple, Icons.directions_walk),
                buildStatCard("Sleep", '${suggestions!['sleep_hours']} hr', "Hours", Colors.green, Icons.nightlight_round),
                buildStatCard("Water", '${suggestions!['water_liters']} lits', "Liters", Colors.blue, Icons.water_drop),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}