import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verzel_prova/components/default_form/default_form.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/services/veiculo_service.dart';

// ignore: must_be_immutable
class EditarVeiculoPage extends StatefulWidget {
  Veiculo? veiculo;

  EditarVeiculoPage(this.veiculo, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<EditarVeiculoPage> createState() => _EditarVeiculoPage(veiculo);
}

class _EditarVeiculoPage extends State<EditarVeiculoPage> {
  Veiculo? veiculo;
  _EditarVeiculoPage(this.veiculo);

  TextEditingController nomeController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  File? _image;
  String? imageIn64;

  @override
  initState() {
    nomeController.text = veiculo!.nome ?? "";
    modeloController.text = veiculo!.modelo ?? "";
    marcaController.text = veiculo!.marca ?? "";
    valorController.text = veiculo!.valor!.toString();
    imageIn64 = veiculo!.foto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        pageTitle: "Editar veículo",
        body: DefaultForm(
            image: imageIn64,
            isEditing: true,
            onPressedButton: () {
              onEditarVeiculo();
            },
            onTapButton: () {
              pegarImagemGaleria();
            },
            nomeController: nomeController,
            modeloController: modeloController,
            marcaController: marcaController,
            valorController: valorController));
  }

  void onEditarVeiculo() async {
    Veiculo veiculoAux = Veiculo();
    veiculoAux.id = veiculo!.id;
    veiculoAux.nome = nomeController.text;
    veiculoAux.modelo = modeloController.text;
    veiculoAux.marca = marcaController.text;
    veiculoAux.valor = double.parse(valorController.text);
    veiculoAux.foto = imageIn64;
    await VeiculoService.updateVeiculo(veiculoAux, context);
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
}
