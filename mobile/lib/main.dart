import 'package:flutter/material.dart';

import 'pages/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/home/ordens_page.dart';
import 'pages/orcamento/orcamento_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProMec GTI',

      // Primeira tela do app
      initialRoute: '/login',

      // Rotas nomeadas (para Navigator.pushNamed funcionar)
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/ordens': (context) => OrdensPage(),
        '/orcamento': (context) => OrcamentoPage(),
      },
    );
  }
}
