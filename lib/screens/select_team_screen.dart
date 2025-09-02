import 'package:flutter/material.dart';
import '../models/team.dart';
import '../services/json_service.dart';
import '../services/shared_preferences_service.dart';
import '../widgets/team_card.dart';

class SelectTeamScreen extends StatefulWidget {
  final VoidCallback onTeamSelected;

  const SelectTeamScreen({required this.onTeamSelected, super.key});

  @override
  State<SelectTeamScreen> createState() => _SelectTeamScreenState();
}

class _SelectTeamScreenState extends State<SelectTeamScreen> {
  final JsonService _jsonService = JsonService();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  void _loadTeams() async {
    final loadedTeams = await _jsonService.loadTeams();
    setState(() {
      teams = loadedTeams;
    });
  }

  void _selectTeam(Team team) async {
    await _prefsService.saveTeam(team);
    widget.onTeamSelected();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolha seu time')),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (_, index) {
          final team = teams[index];
          return TeamCard(
            team: team,
            onTap: () => _selectTeam(team),
          );
        },
      ),
    );
  }
}
