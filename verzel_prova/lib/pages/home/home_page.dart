import 'package:flutter/material.dart';
import 'package:verzel_prova/components/default_card/defalut_card.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/pages/cadastro_veiculo/cadastro_veiculo.dart';
import 'package:verzel_prova/pages/editar_veiculo/editar_veiculo.dart';
import 'package:verzel_prova/services/veiculo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isAdm = true;

  Future<void> _showDialogExclusao(Veiculo veiculo) async {
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
                          await VeiculoService.deleteVeiculo(veiculo);
                          Navigator.of(context).pop();
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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CadastroVeiculo()));
        },
        isFabVisible: true,
        pageTitle: "Lista de Veiculos",
        body: FutureBuilder<List<Veiculo>>(
            future: VeiculoService.getAll(),
            builder: (context, veiculo) {
              if (veiculo.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: veiculo.data!.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () => {
                      if (isAdm) {_showDialogExclusao(veiculo.data![i])}
                    },
                    onLongPress: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => EditarVeiculo(veiculo.data![i])))
                    },
                    child: DefaultCard(
                        nome: veiculo.data![i].nome!,
                        marca: veiculo.data![i].marca!,
                        modelo: veiculo.data![i].modelo!,
                        valor: veiculo.data![i].valor!,
                        imagem: "assets/images/polo.jpg"),
                  );
                },
              );
            }));
  }
}
