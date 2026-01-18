import 'package:flutter/material.dart';
import '../../models/orcamento_model.dart';
import '../../services/orcamento_pdf_service.dart';

class OrcamentoPage extends StatelessWidget {
  OrcamentoPage({super.key});

  final OrcamentoPdfService pdfService = OrcamentoPdfService();

  @override
  Widget build(BuildContext context) {
    final orcamento = OrcamentoModel(
      idOrcamento: 1,
      descricao: 'Troca de embreagem',
      valorTotal: 3500.00,
      data: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Orçamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descrição: ${orcamento.descricao}'),
            Text('Valor Total: R\$ ${orcamento.valorTotal}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await pdfService.gerarPdf(orcamento);
              },
              child: const Text('Gerar PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
