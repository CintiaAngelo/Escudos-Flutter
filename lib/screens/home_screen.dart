import 'package:flutter/material.dart';
import '../models/team.dart';
import '../services/shared_preferences_service.dart';
import '../widgets/generic_image.dart';
import 'select_team_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Team? favoriteTeam;
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  void _loadFavorite() async {
    final team = await _prefsService.loadTeam();
    setState(() {
      favoriteTeam = team;
    });
  }

  void _removeFavorite() async {
    await _prefsService.removeTeam();
    setState(() {
      favoriteTeam = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Time Favorito'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericImage(
              imagePath: favoriteTeam?.logo ?? 'assets/images/placeholder.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SelectTeamScreen(onTeamSelected: _loadFavorite)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              favoriteTeam?.name ?? 'Você ainda não escolheu seu time favorito.',
              textAlign: TextAlign.center,
            ),
            if (favoriteTeam != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _removeFavorite,
              ),
          ],
        ),
      ),
    );
  }
}
