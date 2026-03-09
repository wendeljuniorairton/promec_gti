class ItemOrcamentoModel {

  final String descricao;
  final int quantidade;
  final double valorUnitario;

  ItemOrcamentoModel({

    required this.descricao,
    required this.quantidade,
    required this.valorUnitario,
  });

  double get subtotal => quantidade * valorUnitario;

  factory ItemOrcamentoModel.fromJson(Map<String, dynamic> json) {

    return ItemOrcamentoModel(

      descricao: json['descricao_item'] as String,

      quantidade: json['quantidade'] as int,

      valorUnitario: (json['valor_unitario'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'descricao_item': descricao,
      'quantidade': quantidade,
      'valor_unitario': valorUnitario,
    };
  }
}