import 'dart:convert';
import '../models/usuario_model.dart';
import 'api_service.dart';

class UsuarioService {
  Future<UsuarioModel?> login(String email) async {
    final response = await ApiService.get('/usuarios?email=$email');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UsuarioModel.fromJson(data);
    }

    return null;
  }
}
