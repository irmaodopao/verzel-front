import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final Widget body;
  final String pageTitle;
  final bool isFabVisible;
  final Function()? onPressed;

  // ignore: use_key_in_widget_constructors
  const DefaultPage(
      {required this.body,
      required this.pageTitle,
      this.isFabVisible = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
          ),
          child: SingleChildScrollView(
            child: body,
          )),
      floatingActionButton: isFabVisible
          ? FloatingActionButton(
              onPressed: onPressed,
              tooltip: 'Adicionar veículo',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
