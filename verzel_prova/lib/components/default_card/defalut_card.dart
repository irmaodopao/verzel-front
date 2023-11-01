// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final String imagem;
  final String nome;
  final String marca;
  final String modelo;
  final double valor;

  // ignore: use_key_in_widget_constructors
  const DefaultCard(
      {required this.nome,
      required this.marca,
      required this.modelo,
      required this.valor,
      required this.imagem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                imagem,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: Text(
                "${marca} ${nome} ${modelo}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15.0, left: 10.0, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "R\$",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    " ${valor}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
