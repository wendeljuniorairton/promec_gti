import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/orcamento_model.dart';

class OrcamentoPdfService {
  Future<void> gerarPdf(OrcamentoModel orcamento) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('ORÇAMENTO', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Descrição: ${orcamento.descricao}'),
              pw.Text('Valor total: R\$ ${orcamento.valorTotal.toStringAsFixed(2)}'),
              pw.Text('Data: ${orcamento.data.toString()}'),
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
