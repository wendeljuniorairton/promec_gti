import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oficina - Visão Geral'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StatusCard(
            titulo: 'Aguardando Aprovação',
            quantidade: 2,
            icone: Icons.assignment,
          ),
          _StatusCard(
            titulo: 'Aguardando Peças',
            quantidade: 3,
            icone: Icons.hourglass_empty,
          ),
          _StatusCard(
            titulo: 'Em Manutenção',
            quantidade: 4,
            icone: Icons.build,
          ),
          _StatusCard(
            titulo: 'Finalizados',
            quantidade: 8,
            icone: Icons.check_circle,
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String titulo;
  final int quantidade;
  final IconData icone;

  const _StatusCard({
    required this.titulo,
    required this.quantidade,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icone, size: 32),
        title: Text(titulo),
        trailing: Text(
          quantidade.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
