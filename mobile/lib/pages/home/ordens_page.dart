import 'package:flutter/material.dart';
import '../../models/ordem_servico_model.dart';
import '../../services/ordem_servico_service.dart';

class OrdensPage extends StatelessWidget {
  final OrdemServicoService service = OrdemServicoService();

  OrdensPage({super.key});

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
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final ordens = snapshot.data!;

          return ListView.builder(
            itemCount: ordens.length,
            itemBuilder: (context, index) {
              final ordem = ordens[index];

              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.directions_car,
                    color: _statusColor(ordem.status),
                  ),
                  title: Text(ordem.veiculo),
                  subtitle: Text(
                    '${ordem.status} • ${ordem.diasParado} dias parado',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
