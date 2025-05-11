import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/src/models/user_profile_model.dart';
import 'package:fitness_app/src/widgets/list_tile_item.dart';
import 'package:fitness_app/src/widgets/profile_header.dart';
import 'package:fitness_app/src/widgets/section_title.dart';
import 'package:fitness_app/src/widgets/stat_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfileModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (doc.exists) {
          final data = doc.data();
          setState(() {
            user = UserProfileModel(
              name: data?['username'] ?? 'User',
              program: data?['program'] ?? 'No Program',
              avatar: 'assets/images/profile.png',
              height: data?['height'] ?? '0cm',
              weight: data?['weight'] ?? '0kg',
              age: data?['age'] ?? '0yo',
            );
            isLoading = false;
          });
        } else {
          print('No user data found for this user.');
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading user profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfdfe),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text("No user data found"))
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProfileHeader(user: user!),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(label: 'Height', value: user!.height),
                StatCard(label: 'Weight', value: user!.weight),
                StatCard(label: 'Age', value: user!.age),
              ],
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Account'),
            const ListTileItem(
                icon: Icons.person_outline, label: 'Personal Data'),
            const ListTileItem(
                icon: Icons.emoji_events_outlined, label: 'Achievement'),
            const ListTileItem(
                icon: Icons.history, label: 'Activity History'),
            const ListTileItem(
                icon: Icons.show_chart_outlined, label: 'Workout Progress'),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Notification'),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: true,
              onChanged: (_) {},
              title: const Text('Pop-up Notification'),
              secondary: const Icon(Icons.notifications_none_outlined,
                  color: Colors.green),
              activeColor: Colors.green,
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Other'),
            const ListTileItem(
                icon: Icons.support_agent_outlined, label: 'Contact Us'),
            const ListTileItem(
                icon: Icons.privacy_tip_outlined, label: 'Privacy Policy'),
            const ListTileItem(
                icon: Icons.settings_outlined, label: 'Settings'),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
