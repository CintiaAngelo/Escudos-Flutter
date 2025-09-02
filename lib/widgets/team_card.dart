import 'package:flutter/material.dart';
import '../models/team.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  final VoidCallback onTap;

  const TeamCard({required this.team, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset(team.logo, width: 50, height: 50),
        title: Text(team.name),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
