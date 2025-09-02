import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Aplicativo desenvolvido em Flutter.\n\n"
          "📌 Funcionalidades:\n"
          "- Escolher e salvar seu time favorito\n"
          "- Persistência com SharedPreferences\n"
          "- Leitura de JSON\n"
          "- Navegação com Drawer e BottomNavigationBar\n"
          "- Suporte a tema claro/escuro\n\n"
          "Exemplo acadêmico para estudo de Flutter 🚀",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
