import 'package:flutter/material.dart';
import '../../models/ordem_servico_model.dart';
import '../../services/ordem_servico_service.dart';
import '../orcamento/orcamento_page.dart';

class OrdensPage extends StatelessWidget {
  final OrdemServicoService service = OrdemServicoService();

  OrdensPage({super.key});

  Color statusColor(String status) {
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
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ordem.veiculo,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text('Status: ${ordem.status}'),
        Text('Dias parado: ${ordem.diasParado}'),
        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Ver Orçamento'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrcamentoPage(),
                ),
              );
            },
          ),
        ),
      ],
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
