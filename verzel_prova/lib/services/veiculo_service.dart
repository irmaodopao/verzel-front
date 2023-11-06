import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzel_prova/env/environments.dart';
import 'package:verzel_prova/models/veiculo.dart';
import 'package:verzel_prova/utils/functions_utils.dart';

class VeiculoService {
  static String url = "${Environments.url}/veiculo";

  static Future<List<Veiculo>> getAll() async {
    Response res = await get(Uri.parse("$url/getAll"));
    if (res.statusCode == 200) {
      List result = jsonDecode(utf8.decode(res.bodyBytes));
      return result.map((e) => Veiculo.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  static Future<void> createVeiculo(
      Veiculo? veiculo, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (FunctionsUtils.isTokenExpired(token!)) {
      // ignore: use_build_context_synchronously
      FunctionsUtils.redirectToAdmLoginWhenTokenExpired(context);
      return;
    }
    Response res = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(veiculo!.toMapWithoutId()));
    if (res.statusCode == 201) {
      // ignore: use_build_context_synchronously
      FunctionsUtils.redirectToHomePage(context);
    }
  }

  static Future<void> updateVeiculo(
      Veiculo? veiculo, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (FunctionsUtils.isTokenExpired(token!)) {
      // ignore: use_build_context_synchronously
      FunctionsUtils.redirectToAdmLoginWhenTokenExpired(context);
      return;
    }
    Response res = await put(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(veiculo!.toMapWithId()));
    if (res.statusCode == 200) {
      // ignore: use_build_context_synchronously
      FunctionsUtils.redirectToHomePage(context);
    }
  }

  static Future<void> deleteVeiculo(
      Veiculo? veiculo, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (FunctionsUtils.isTokenExpired(token!)) {
      // ignore: use_build_context_synchronously
      FunctionsUtils.redirectToAdmLoginWhenTokenExpired(context);
      return;
    }
    Response res = await delete(Uri.parse("$url/${veiculo?.id}"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    if (res.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
