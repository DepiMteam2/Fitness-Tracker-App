import 'package:fitness_app/src/models/user_profile_model.dart';
import 'package:fitness_app/src/widgets/list_tile_item.dart';
import 'package:fitness_app/src/widgets/profile_header.dart';
import 'package:fitness_app/src/widgets/section_title.dart';
import 'package:fitness_app/src/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserProfileModel(
      name: 'Masi Ramezanzade',
      program: 'Lose a Fat Program',
      avatar: 'assets/images/profile.png',
      height: '180cm',
      weight: '65kg',
      age: '22yo',
    );

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_horiz, color: Colors.black87),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProfileHeader(user: user),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(label: 'Height', value: user.height),
                StatCard(label: 'Weight', value: user.weight),
                StatCard(label: 'Age', value: user.age),
              ],
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Account'),
            const ListTileItem(
                icon: Icons.person_outline, label: 'Personal Data'),
            const ListTileItem(
                icon: Icons.emoji_events_outlined, label: 'Achievement'),
            const ListTileItem(icon: Icons.history, label: 'Activity History'),
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
