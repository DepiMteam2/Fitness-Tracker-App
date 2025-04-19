import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ListTileItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.cyan),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
