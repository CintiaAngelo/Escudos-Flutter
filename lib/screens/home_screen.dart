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
        title: const Text('Meu Time Favorito'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Sobre"),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericImage(
              imagePath: favoriteTeam?.logo ?? 'assets/images/placeholder.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectTeamScreen(onTeamSelected: _loadFavorite),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              favoriteTeam?.name ?? 'Você ainda não escolheu seu time favorito.',
              textAlign: TextAlign.center,
            ),
            if (favoriteTeam != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Remover"),
                      content: const Text("Tem certeza que deseja remover seu time favorito?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancelar"),
                          onPressed: () => Navigator.pop(ctx, false),
                        ),
                        TextButton(
                          child: const Text("Remover"),
                          onPressed: () => Navigator.pop(ctx, true),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    _removeFavorite();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Time removido com sucesso!")),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
