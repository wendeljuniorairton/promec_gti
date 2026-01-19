class OrcamentoModel {
  final int idOrcamento;
  final DateTime dataOrcamento;
  final String status;
  final double valor;
  final String descricao;

  OrcamentoModel({
    required this.idOrcamento,
    required this.dataOrcamento,
    required this.status,
    required this.valor,
    required this.descricao,
  });

  factory OrcamentoModel.fromJson(Map<String, dynamic> json) {
    return OrcamentoModel(
      idOrcamento: json['id_orcamento'] as int,
      dataOrcamento: DateTime.parse(json['data_orcamento'] as String),
      status: json['status_orcamento'] as String,
      valor: (json['valor_orcamento'] as num).toDouble(),
      descricao: json['descricao_orcamento'] as String,
    );
  }
}
