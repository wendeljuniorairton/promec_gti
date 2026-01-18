import '../models/ordem_servico_model.dart';

class OrdemServicoService {
  Future<List<OrdemServicoModel>> listarOrdens() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      OrdemServicoModel(
        idOrdemServico: 1,
        veiculo: 'Caminhão Volvo FH',
        status: 'Aguardando Peças',
        dataEntrada: DateTime.now().subtract(const Duration(days: 12)),
      ),
      OrdemServicoModel(
        idOrdemServico: 2,
        veiculo: 'Retroescavadeira CAT',
        status: 'Aguardando Aprovação',
        dataEntrada: DateTime.now().subtract(const Duration(days: 5)),
      ),
      OrdemServicoModel(
        idOrdemServico: 3,
        veiculo: 'Fiat Strada',
        status: 'Em Manutenção',
        dataEntrada: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
