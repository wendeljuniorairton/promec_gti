class OrdemServicoModel {
  final int idOrdemServico;
  final String veiculoIdentificacao;
  final String status;
  final DateTime dataEntrada;

  OrdemServicoModel({
    required this.idOrdemServico,
    required this.veiculoIdentificacao,
    required this.status,
    required this.dataEntrada,
  });

  factory OrdemServicoModel.fromJson(Map<String, dynamic> json) {
    return OrdemServicoModel(
      idOrdemServico: json['id_ordem_servico'] as int,
      dataEntrada: DateTime.parse(json['data_ordem_servico'] as String),
      status: json['status_ordem_servico'] as String,
      veiculoIdentificacao: json['identifica_veiculo'] as String,
    );
  }

  int get diasParado => DateTime.now().difference(dataEntrada).inDays;
}
