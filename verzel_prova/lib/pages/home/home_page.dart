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

  Future<void> _showDialogExclusao(Veiculo veiculo,List<Veiculo> veiculoData) async {
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
                          setState(() {
                            veiculoData.remove(veiculo);
                          });
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
        body: SingleChildScrollView( // Envolver o conteúdo com SingleChildScrollView
          child: FutureBuilder<List<Veiculo>>(
            future: VeiculoService.getAll(),
            builder: (context, veiculos) {
              if (veiculos.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(veiculos.data!.isEmpty || veiculos.hasError){
                return const Center(
                  child: Text("Sem veículos na vitrine"),
                );
              }
              return Column(
                children: veiculos.data!.map((veiculo) {
                  return GestureDetector(
                    onTap: () {
                      if (isAdm) {
                        _showDialogExclusao(veiculo,veiculos.data!);
                      }
                    },
                    onLongPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EditarVeiculo(veiculo)));
                    },
                    child: DefaultCard(
                        nome: veiculo.nome!,
                        marca: veiculo.marca!,
                        modelo: veiculo.modelo!,
                        valor: veiculo.valor!,
                        imagem: "assets/images/polo.jpg"),
                  );
                }).toList(),
              );
            },
          ),
        ),
    );
  }
}
