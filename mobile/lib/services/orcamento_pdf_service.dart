import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/orcamento_model.dart';

class OrcamentoPdfService {
  Future<void> gerarPdf(OrcamentoModel orcamento, {int? idOrdemServico}) async {
    final pdf = pw.Document();

    final dataFormatada =
        '${orcamento.dataOrcamento.day.toString().padLeft(2, '0')}/'
        '${orcamento.dataOrcamento.month.toString().padLeft(2, '0')}/'
        '${orcamento.dataOrcamento.year}';

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'ORÇAMENTO',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),

              if (idOrdemServico != null)
                pw.Text('Ordem de Serviço: #$idOrdemServico'),

              pw.Text('ID do Orçamento: #${orcamento.idOrcamento}'),
              pw.Text('Data: $dataFormatada'),
              pw.Text('Status: ${orcamento.status}'),

              pw.SizedBox(height: 16),
              pw.Text(
                'Descrição',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 6),
              pw.Text(orcamento.descricao),

              pw.SizedBox(height: 16),
              pw.Text(
                'Valor Total',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 6),
              pw.Text('R\$ ${orcamento.valor.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
