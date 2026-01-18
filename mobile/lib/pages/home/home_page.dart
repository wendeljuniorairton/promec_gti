import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bem-vindo!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // 🔹 BOTÃO PRINCIPAL
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/orcamento');
              },
              child: const Text('Criar Orçamento'),
            ),

            const SizedBox(height: 24),

            // 🔹 BOTÃO SECUNDÁRIO (OPCIONAL)
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ordens');
              },
              child: const Text('Ordens de Serviço'),
            ),
          ],
        ),
      ),
    );
  }
}
