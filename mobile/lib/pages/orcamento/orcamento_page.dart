import 'package:flutter/material.dart';

import '../../services/orcamento_pdf_service.dart';
import '../../services/orcamento_service.dart';
import '../../models/orcamento_model.dart';

class OrcamentoPage extends StatefulWidget {
  final int? idOrdemServico;

  const OrcamentoPage({super.key, this.idOrdemServico});

  @override
  State<OrcamentoPage> createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

  final _service = OrcamentoService();
  final _pdfService = OrcamentoPdfService();

  bool _salvando = false;

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final descricao = _descricaoController.text.trim();
    final valorTexto = _valorController.text.trim().replaceAll(',', '.');

    if (descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe a descrição.')),
      );
      return;
    }

    final valor = double.tryParse(valorTexto);
    if (valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um valor válido.')),
      );
      return;
    }

    if (widget.idOrdemServico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Abra o orçamento a partir de uma Ordem de Serviço para salvar no banco.'),
        ),
      );
      return;
    }

    setState(() => _salvando = true);

    try {
      final idOrcamento = await _service.criarParaOrdem(
        idOrdemServico: widget.idOrdemServico!,
        descricao: descricao,
        valor: valor,
      );

      // monta um OrcamentoModel local para gerar PDF
      final orcamento = OrcamentoModel(
        idOrcamento: idOrcamento,
        dataOrcamento: DateTime.now(),
        status: 'PENDENTE',
        valor: valor,
        descricao: descricao,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Orçamento #$idOrcamento salvo com sucesso!')),
      );

      // gerar PDF logo após salvar (opcional)
      await _pdfService.gerarPdf(
        orcamento,
        idOrdemServico: widget.idOrdemServico,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Modo criar
    if (widget.idOrdemServico == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Criar Orçamento')),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Para criar e salvar um orçamento no banco, acesse por uma Ordem de Serviço.\n\n'
            'Ex.: Home → Ordens → tocar na OS → Criar Orçamento.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Criar Orçamento (OS #${widget.idOrdemServico})')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição do orçamento',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(
                labelText: 'Valor total (ex: 350.00)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _salvando ? null : _salvar,
              icon: const Icon(Icons.save),
              label: Text(_salvando ? 'Salvando...' : 'Salvar orçamento e gerar PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
