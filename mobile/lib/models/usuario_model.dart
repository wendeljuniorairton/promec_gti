class UsuarioModel {
  final int idUsuario;
  final String nome;
  final String email;
  final String tipoUsuario; // cliente | mecanico | admin

  UsuarioModel({
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.tipoUsuario,
  });

  // Converter JSON → Objeto
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      idUsuario: json['id_usuario'],
      nome: json['nm_usuario'],
      email: json['email_usuario'],
      tipoUsuario: json['tipo_usuario'],
    );
  }

  // Converter Objeto → JSON
  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nm_usuario': nome,
      'email_usuario': email,
      'tipo_usuario': tipoUsuario,
    };
  }
}
