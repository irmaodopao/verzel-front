import 'package:flutter/material.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/services/veiculo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      pageTitle: "Lista de Veiculos", 
      body: FutureBuilder<List<Veiculo>>(
        future: VeiculoService.getAll(),
        builder: (context, veiculo){
          if(veiculo.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: veiculo.data!.length,
            itemBuilder: (BuildContext context, int index){
              return const Text("");
            },
          );
        }
      ) 
    );
  }
}
