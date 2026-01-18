import 'package:flutter/material.dart';
import '../../models/ordem_servico_model.dart';
import '../../services/ordem_servico_service.dart';
import '../orcamento/orcamento_page.dart';

class OrdensPage extends StatelessWidget {
  OrdensPage({super.key});

  final OrdemServicoService service = OrdemServicoService();

  Color _statusColor(String status) {
    switch (status) {
      case 'Aguardando Peças':
        return Colors.red;
      case 'Aguardando Aprovação':
        return Colors.orange;
      case 'Em Manutenção':
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordens de Serviço')),
      body: FutureBuilder<List<OrdemServicoModel>>(
        future: service.listarOrdens(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }
          final ordens = snapshot.data ?? [];

          if (ordens.isEmpty) {
            return const Center(child: Text('Nenhuma ordem encontrada.'));
          }

          return ListView.builder(
            itemCount: ordens.length,
            itemBuilder: (context, index) {
              final ordem = ordens[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Icon(Icons.directions_car,
                      color: _statusColor(ordem.status)),
                  title: Text('Veículo: ${ordem.veiculoIdentificacao}'),
                  subtitle:
                      Text('${ordem.status} • ${ordem.diasParado} dias parado'),
                  trailing: const Icon(Icons.picture_as_pdf),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OrcamentoPage()),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
