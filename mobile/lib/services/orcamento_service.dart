import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/orcamento_model.dart';
import 'api_service.dart';

class OrcamentoService {
  /// ============================
  /// BUSCAR orçamento pela OS
  /// ============================
  Future<OrcamentoModel?> buscarPorOrdem(int idOrdemServico) async {
    final response =
        await ApiService.get('/ordens/$idOrdemServico/orcamento');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return OrcamentoModel.fromJson(data);
    }

    if (response.statusCode == 404) return null;

    throw Exception('Erro ao buscar orçamento (${response.statusCode})');
  }

  /// ============================
  /// CRIAR orçamento para uma OS
  /// ============================
  Future<int> criarParaOrdem({
    required int idOrdemServico,
    required String descricao,
    required double valor,
  }) async {
    final body = jsonEncode({
      'descricao_orcamento': descricao,
      'valor_orcamento': valor,
    });

    final http.Response response = await ApiService.post(
      '/ordens/$idOrdemServico/orcamento',
      body: body,
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['id_orcamento'] as int;
    }

    throw Exception('Erro ao criar orçamento (${response.statusCode})');
  }
}
