class OrdemServicoModel {
  final int idOrdemServico;
  final String veiculo;
  final String status;
  final DateTime dataEntrada;

  OrdemServicoModel({
    required this.idOrdemServico,
    required this.veiculo,
    required this.status,
    required this.dataEntrada,
  });

  int get diasParado {
    return DateTime.now().difference(dataEntrada).inDays;
  }
}
