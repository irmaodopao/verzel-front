import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final double? width;
  final bool isButtonStyle;

  // ignore: use_key_in_widget_constructors
  const DefaultButton(
      {required this.buttonText,
      required this.onPressed,
      this.width,
      this.isButtonStyle = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
        style: isButtonStyle ? ElevatedButton.styleFrom(
          primary: Colors.white, // Define a cor do botão como branca
        ) : null,
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.center,
          child: Text(buttonText,style: isButtonStyle? const TextStyle(color: Colors.black) :null),
        ),
      ),
    );
  }
}