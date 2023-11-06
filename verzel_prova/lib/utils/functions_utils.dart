import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/pages/cadastro_veiculo/cadastro_veiculo_page.dart';
import 'package:verzel_prova/pages/editar_veiculo/editar_veiculo_page.dart';
import 'package:verzel_prova/pages/home/home_page.dart';
import 'package:verzel_prova/pages/login_adm/login_adm_page.dart';
import 'package:verzel_prova/utils/rotas_enum.dart';

class FunctionsUtils {
  static List<Veiculo>? ordenarPorValor(List<Veiculo> listaVeiculos) {
    listaVeiculos.sort((a, b) => a.valor!.compareTo(b.valor!));
    return listaVeiculos;
  }

  static String maskDoubleToReal(double valor) {
    final mask = NumberFormat('#,##0.00', 'pt_BR');
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

  static bool isTokenExpired(String token) {
    List<String> tokenParts = token.split('.');
    if (tokenParts.length != 3) {
      return true;
    }
    String decodedPayload =
        String.fromCharCodes(base64Url.decode(tokenParts[1]));
    Map<String, dynamic> payloadMap = jsonDecode(decodedPayload);

    if (payloadMap.containsKey('exp')) {
      int expiryTimeInSeconds = payloadMap['exp'];
      DateTime expiryDateTime =
          DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);
      return DateTime.now().isAfter(expiryDateTime);
    } else {
      return true;
    }
  }

  static void redirectToAdmLoginWhenTokenExpired(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginAdmPage()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Seu token expirou! Faça seu login novamente')),
    );
  }

   static void redirectToHomePage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }


  static void validateTokenAndRedirect(
      BuildContext context, String route,
      [Veiculo? veiculo, Future<void>? showDialog]) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && !FunctionsUtils.isTokenExpired(token)) {
      if (route == routeToString(Rotas.EXCLUIR)) {
        showDialog;
        return;
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        if (route == routeToString(Rotas.CADASTRAR)) {
          return const CadastroVeiculoPage();
        }
        return EditarVeiculoPage(veiculo);
      }));
    } else {
      if (route != routeToString(Rotas.CADASTRAR)) {
        // ignore: use_build_context_synchronously
        FunctionsUtils.defaultShowDialog(context, 'Atenção!',
            'Você precisa estar logado para executar essa ação!', true);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginAdmPage()));
      }
    }
  }
}
