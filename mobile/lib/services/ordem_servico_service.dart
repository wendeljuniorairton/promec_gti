import 'dart:convert';
import '../models/ordem_servico_model.dart';
import 'api_service.dart';

class OrdemServicoService {
  Future<List<OrdemServicoModel>> listarOrdens() async {
    final response = await ApiService.get('/ordens');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => OrdemServicoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Falha ao buscar ordens (${response.statusCode})');
  }
}
