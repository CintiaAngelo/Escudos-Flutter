import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/team.dart';

class JsonService {
  Future<List<Team>> loadTeams() async {
    final String jsonString = await rootBundle.loadString('assets/teams.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Team.fromJson(data)).toList();
  }
}
