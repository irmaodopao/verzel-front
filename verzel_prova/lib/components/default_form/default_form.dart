import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:verzel_prova/components/default_input/default_input.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';

class DefaultForm extends StatelessWidget {
  final Function()? onPressedButton;
  final Function()? onTapButton;
  final TextEditingController nomeController;
  final TextEditingController modeloController;
  final TextEditingController marcaController;
  final TextEditingController valorController;
  final bool isEditing;
  final String? image;

  const DefaultForm(
      {Key? key,
      required this.onPressedButton,
      required this.onTapButton,
      required this.nomeController,
      required this.modeloController,
      required this.marcaController,
      required this.valorController,
      this.isEditing = false,
      required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        textInputType: TextInputType.number,
        labelText: 'Valor',
        controller: valorController,
      ),
      const SizedBox(
        height: 15,
      ),
      GestureDetector(
        onTap: onTapButton,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(50),
          color: Colors.grey,
          child: Container(
            height: 50,
            color: Colors.white,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  image == null ? "Foto do veículo" : "Editar foto do veículo",
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      if (image != null) 
        Image.memory(base64Decode(image!)),
      const SizedBox(
        height: 15,
      ),
      DefaultButton(
          buttonText: isEditing ? 'Editar veículo' : 'Adicionar veículo',
          onPressed: onPressedButton),
      const SizedBox(
        height: 15,
      )
    ]);
  }
}
