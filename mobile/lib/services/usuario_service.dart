import '../models/usuario_model.dart';

class UsuarioService {
  Future<UsuarioModel?> login(String email) async {
    // Simula tempo de resposta da API
    await Future.delayed(const Duration(seconds: 1));

    // Simula usuário encontrado
    return UsuarioModel(
      idUsuario: 1,
      nome: 'Usuário Teste',
      email: email,
      tipoUsuario: 'cliente',
    );
  }
}
