class VeiculoModel {
  final int idVeiculo;
  final int idUsuario;
  final String tipoVeiculo;
  final String identificacao;
  final String controle; // KM ou HORAS

  VeiculoModel({
    required this.idVeiculo,
    required this.idUsuario,
    required this.tipoVeiculo,
    required this.identificacao,
    required this.controle,
  });

  factory VeiculoModel.fromJson(Map<String, dynamic> json) {
    return VeiculoModel(
      idVeiculo: json['id_veiculo'],
      idUsuario: json['id_usuario'],
      tipoVeiculo: json['tipo_veiculo'],
      identificacao: json['identifica_veiculo'],
      controle: json['controle_veiculo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_veiculo': idVeiculo,
      'id_usuario': idUsuario,
      'tipo_veiculo': tipoVeiculo,
      'identifica_veiculo': identificacao,
      'controle_veiculo': controle,
    };
  }
}
