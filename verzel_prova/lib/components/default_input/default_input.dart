

import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget{

  final String labelText;
  final TextEditingController? controller;
  final Function()? onEditingComplete;
  final TextInputType? textInputType;

  const DefaultInput({required this.labelText,this.controller, this.onEditingComplete,this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        border: const OutlineInputBorder(),
      ),
    );
  }


}