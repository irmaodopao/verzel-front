import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final Widget body;
  final String pageTitle;

  // ignore: use_key_in_widget_constructors
  const DefaultPage({required this.body, required this.pageTitle});

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
    );
  }
}
