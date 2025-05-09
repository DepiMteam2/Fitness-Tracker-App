import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;
  const HeaderWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning! 👋',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.search, size: 28),
        const SizedBox(width: 12),
        const CircleAvatar(child: Icon(Icons.person, size: 28)),
      ],
    );
  }
}
