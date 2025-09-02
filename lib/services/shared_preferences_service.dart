import 'package:shared_preferences/shared_preferences.dart';
import '../models/team.dart';
import 'dart:convert';


class SharedPreferencesService {
  static const _teamKey = 'favorite_team';

  Future<void> saveTeam(Team team) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_teamKey, json.encode(team.toJson()));
  }

  Future<Team?> loadTeam() async {
    final prefs = await SharedPreferences.getInstance();
    final teamJson = prefs.getString(_teamKey);
    if (teamJson != null) {
      return Team.fromJson(json.decode(teamJson));
    }
    return null;
  }

  Future<void> removeTeam() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_teamKey);
  }
}
