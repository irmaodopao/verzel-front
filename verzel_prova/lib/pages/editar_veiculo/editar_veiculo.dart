import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verzel_prova/components/default_input/default_input.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';

class EditarVeiculo extends StatefulWidget {

  Veiculo? veiculo;

  EditarVeiculo(this.veiculo, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<EditarVeiculo> createState() => _EditarVeiculo(veiculo);
}

class _EditarVeiculo extends State<EditarVeiculo> {

  Veiculo? veiculo;
 _EditarVeiculo(this.veiculo);

  TextEditingController nomeController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  File? _image;
  
 
  

  @override
  initState(){
    print(veiculo!.nome);
    print(veiculo!.modelo);
    print(veiculo!.marca);
    nomeController.text = veiculo!.nome ?? "";
    modeloController.text = veiculo!.modelo ?? "";
    marcaController.text = veiculo!.marca ?? "";
    valorController.text = veiculo!.valor!.toString();
  }

  Future<void> pegarImagemGaleria() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      List<int> imageBytes = _image!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      print(base64Image);
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        pageTitle: "Editar veículo",
        body: Column(children: [
          DefaultInput(
            labelText: 'Nome',
            controller: nomeController,
          ),
          const SizedBox(
            height: 15,
          ),
          DefaultInput(
            labelText: 'Modelo',
            controller: modeloController,
          ),
          const SizedBox(
            height: 15,
          ),
          DefaultInput(
            labelText: 'Marca',
            controller: marcaController,
          ),
          const SizedBox(
            height: 15,
          ),
          DefaultInput(
            textInputType: TextInputType.number,
            labelText: 'Valor',
            controller: valorController,
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              pegarImagemGaleria();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(50),
              color: Colors.grey,
              child: Container(
                height: 50,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.center,
                    child: Text(
                  "Foto do veículo",
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          DefaultButton(buttonText: 'Adicionar', onPressed: () {}),
          const SizedBox(
            height: 15,
          )
        ]));
  }
}
