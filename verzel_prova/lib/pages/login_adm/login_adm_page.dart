import 'package:flutter/material.dart';
import 'package:verzel_prova/components/default_input/default_input.dart';
import 'package:verzel_prova/components/default_page/default_page.dart';
import 'package:verzel_prova/components/defaut_button/default_button.dart';

class LoginAdmPage extends StatefulWidget {
  const LoginAdmPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginAdmPage createState() => _LoginAdmPage();
}

class _LoginAdmPage extends State<LoginAdmPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        pageTitle: 'Login Adm',
        body: Column(
          children: [
            const Text("Faça seu login para proseguir",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 15,
            ),
            DefaultInput(
              labelText: 'Usuário',
              controller: userController,
            ),
            const SizedBox(
              height: 15,
            ),
            DefaultInput(
              labelText: 'Senha',
              controller: senhaController,
            ),
            const SizedBox(
              height: 15,
            ),
            DefaultButton(
                buttonText: 'Entrar',
                onPressed: () {
                  onLoginAdm();
                }),
          ],
        ));
  }
  onLoginAdm() async{

  }
}