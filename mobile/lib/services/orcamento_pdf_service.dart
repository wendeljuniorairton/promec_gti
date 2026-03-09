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
  pw.MultiPage(

    margin: const pw.EdgeInsets.all(32),
  

    build: (context) => [



      // ----------- IDENTIFICAÇÃO DA EMPRESA ----------------------------------

      pw.Divider(),

      pw.Text(
        'PROMEC-GTI',
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
        ),
      ),

      pw.Text('Rua: Rua do Sol, 123 - Centro'),
      pw.Text('Cidade: São Paulo - SP'),
      pw.Text('Telefone: (11) 1234-5678'),

      pw.Divider(),

      // ----------- DADOS DO ORÇAMENTO ----------------------------------

      pw.Text(
        'ORÇAMENTO',
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
        ),
      ),

      pw.SizedBox(height: 12),

      if (idOrdemServico != null)
        //pw.Text('Ordem de Serviço: #$idOrdemServico'),

      pw.Text('ID do Orçamento: #${orcamento.idOrcamento}'),
      pw.Text('Data: $dataFormatada'),
      pw.Text('Status: ${orcamento.status}'),

      pw.Divider(),

      // ----------- DESCRIÇÃO ----------------------------------

      pw.SizedBox(height: 16),

      pw.Text(
        'Descrição',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),

      pw.SizedBox(height: 6),

      pw.Text(orcamento.descricao),

      pw.SizedBox(height: 16),
      pw.Divider(),
      // ----------- VALOR ----------------------------------

      pw.Text(
        'Valor Total',
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),

      pw.SizedBox(height: 6),

      pw.Text(
        'R\$ ${orcamento.valor.toStringAsFixed(2)}',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Divider(),
    ],

    /// RODAPÉ
    footer: (context) => pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Text(
        'PROMEC-GTI - Garantia de 90 dias   |   Página ${context.pageNumber}/${context.pagesCount}',
        style: const pw.TextStyle(fontSize: 10),
      ),
    ),
  ),
);

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}