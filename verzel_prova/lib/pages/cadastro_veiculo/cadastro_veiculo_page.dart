import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verzel_prova/components/default_form/default_form.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/pages/home/home_page.dart';
import 'package:verzel_prova/services/veiculo_service.dart';

class CadastroVeiculoPage extends StatefulWidget {
  const CadastroVeiculoPage({Key? key}) : super(key: key);

  @override
  State<CadastroVeiculoPage> createState() => _CadastroVeiculoPage();
}

class _CadastroVeiculoPage extends State<CadastroVeiculoPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  File? _image;
  String? imageIn64;

  bool camposEstaoVazios() {
    return nomeController.text.isEmpty ||
        modeloController.text.isEmpty ||
        marcaController.text.isEmpty ||
        valorController.text.isEmpty || 
        imageIn64 == null;
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
      imageIn64 = base64Encode(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        pageTitle: "Cadastro de veículo",
        body: DefaultForm(
            image: imageIn64,
            onPressedButton: () {
              onCriarVeiculo();
            },
            onTapButton: () {
              pegarImagemGaleria();
            },
            nomeController: nomeController,
            modeloController: modeloController,
            marcaController: marcaController,
            valorController: valorController));
  }

  onCriarVeiculo() async{
    if (!camposEstaoVazios()) {
      Veiculo veiculo = Veiculo();
      veiculo.nome = nomeController.text;
      veiculo.modelo = modeloController.text;
      veiculo.marca = marcaController.text;
      veiculo.valor = double.parse(valorController.text);
      veiculo.foto = imageIn64;
      await VeiculoService.createVeiculo(veiculo);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos!')),
      );
    }
  }
}
