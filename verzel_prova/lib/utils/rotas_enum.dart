enum Rotas {
  CADASTRAR,
  EDITAR,
  EXCLUIR
}

String routeToString(Rotas rota) {
  switch (rota) {
    case Rotas.CADASTRAR:
      return "cadastrarVeiculo";
    case Rotas.EDITAR:
      return "editarVeiculo";
    case Rotas.EXCLUIR:
      return "excluirVeiculo";
  }
}

Rotas stringToRoute(String rota) {
  switch (rota) {
    case "cadastrarVeiculo":
      return Rotas.CADASTRAR;
    case "editarVeiculo":
      return Rotas.EDITAR;
    case "excluirVeiculo":
      return Rotas.EXCLUIR;
    default:
      throw Exception("Rota não encontrada para a string fornecida: $rota");
  }
}