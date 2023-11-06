import 'package:flutter/material.dart';
import 'package:verzel_prova/components/default_card/defalut_card.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/services/veiculo_service.dart';
import 'package:verzel_prova/utils/functions_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  Future<void> _showDialogExclusao(
      Veiculo veiculo, List<Veiculo> veiculoData) async {
    return showDialog(
        context: context,
        builder: (conext) {
          return AlertDialog(
            title: const Text("Exclusão de veículo"),
            content: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                      "Tem certeza que quer excluir o veículo ${veiculo.nome} ?"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultButton(
                        width: MediaQuery.of(conext).size.width * 0.25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        buttonText: 'Cancelar'),
                    DefaultButton(
                        width: MediaQuery.of(conext).size.width * 0.25,
                        onPressed: () async {
                          await VeiculoService.deleteVeiculo(veiculo, context);
                          setState(() {
                            veiculoData.remove(veiculo);
                          });
                        },
                        buttonText: 'Deletar')
                  ],
                )
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      onPressed: () async {
        // ignore: use_build_context_synchronously
        FunctionsUtils.validateTokenAndRedirect(context, "cadastrarVeiculo");
      },
      isFabVisible: true,
      pageTitle: "Lista de Veiculos",
      body: SingleChildScrollView(
        child: FutureBuilder<List<Veiculo>>(
          future: VeiculoService.getAll(),
          builder: (context, veiculos) {
            if (veiculos.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (veiculos.data!.isEmpty || veiculos.hasError) {
              return const Center(
                child: Text("Sem veículos na vitrine"),
              );
            }
            return Column(
              children: FunctionsUtils.ordenarPorValor(veiculos.data!)!
                  .map((veiculo) {
                return GestureDetector(
                  onTap: () async {
                    FunctionsUtils.validateTokenAndRedirect(
                        context,
                        "excluirVeiculo",
                        veiculo,
                        _showDialogExclusao(veiculo, veiculos.data!));
                  },
                  onLongPress: () async {
                    FunctionsUtils.validateTokenAndRedirect(
                        context, "editarVeiculo", veiculo);
                  },
                  child: DefaultCard(
                      nome: veiculo.nome!,
                      marca: veiculo.marca!,
                      modelo: veiculo.modelo!,
                      valor: veiculo.valor!,
                      imagem: veiculo.foto!),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
