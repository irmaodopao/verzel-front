import 'dart:convert';

import 'package:http/http.dart';
import 'package:verzel_prova/env/environments.dart';
import 'package:verzel_prova/models/veiculo.dart';

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

  static Future<void> createVeiculo(Veiculo? veiculo) async {
    Response res = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(veiculo!.toMapWithoutId()));
    if (res.statusCode != 201) {
      throw Exception(res.reasonPhrase);
    }
  }

  static Future<void> updateVeiculo(Veiculo? veiculo) async {
    Response res = await put(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(veiculo!.toMapWithId()));
      print(res.statusCode);
    if (res.statusCode != 200) {
      throw Exception(res.reasonPhrase);
    }
  }

  static Future<void> deleteVeiculo(Veiculo? veiculo) async {
    Response res = await delete(Uri.parse("$url/${veiculo?.id}"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (res.statusCode != 200) {
      throw Exception(res.reasonPhrase);
    }
  }
}
