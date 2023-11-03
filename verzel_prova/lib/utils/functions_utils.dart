import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';

class FunctionsUtils {
  static List<Veiculo>? ordenarPorValor(List<Veiculo> listaVeiculos) {
    listaVeiculos.sort((a, b) => a.valor!.compareTo(b.valor!));
    return listaVeiculos;
  }

  static String maskDoubleToReal(double valor) {
    final mask =  NumberFormat('#,##0.00', 'pt_BR');
    return mask.format(valor);
  }

  static Future<void> defaultShowDialog(BuildContext context, String title,
      String description, bool isOneButton) async {
    return showDialog(
        context: context,
        builder: (conext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(description),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultButton(
                        width: MediaQuery.of(conext).size.width * 0.25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        buttonText: !isOneButton ? 'Cancelar' : 'OK'),
                    !isOneButton
                        ? DefaultButton(
                            width: MediaQuery.of(conext).size.width * 0.25,
                            onPressed: () async {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            },
                            buttonText: 'Deletar')
                        : const SizedBox()
                  ],
                )
              ],
            )),
          );
        });
  }
}
