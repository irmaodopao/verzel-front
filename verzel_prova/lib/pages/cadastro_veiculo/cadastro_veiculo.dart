import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verzel_prova/components/default_form/default_form.dart';
import 'package:verzel_prova/components/default_input/default_input.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/pages/home/home_page.dart';
import 'package:verzel_prova/services/veiculo_service.dart';

class CadastroVeiculo extends StatefulWidget {
  @override
  State<CadastroVeiculo> createState() => _CadastroVeiculo();
}

class _CadastroVeiculo extends State<CadastroVeiculo> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  File? _image;

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
        pageTitle: "Cadastro de veículo",
        body: DefaultForm(
            onPressedButton: () {
              criarVeiculo();
            },
            onTapButton: () {
              pegarImagemGaleria();
            },
            nomeController: nomeController,
            modeloController: modeloController,
            marcaController: marcaController,
            valorController: valorController));
  }

  criarVeiculo() async {
    Veiculo veiculo = Veiculo();
    veiculo.nome = nomeController.text;
    veiculo.modelo = modeloController.text;
    veiculo.marca = marcaController.text;
    veiculo.valor = double.parse(valorController.text);
    veiculo.foto = "123";
    await VeiculoService.createVeiculo(veiculo);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}
