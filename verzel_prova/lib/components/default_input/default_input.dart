

import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget{

  final String labelText;
  final TextEditingController? controller;
  final Function()? onEditingComplete;
  final TextInputType? textInputType;
  final bool obscureText;

  const DefaultInput({required this.labelText,this.controller, this.onEditingComplete,this.textInputType,this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
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