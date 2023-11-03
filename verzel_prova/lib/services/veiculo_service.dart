import 'dart:convert';

import 'package:http/http.dart';
import 'package:verzel_prova/models/veiculo.dart';

class VeiculoService {
  static String url =
      "http://ec2-15-228-78-229.sa-east-1.compute.amazonaws.com:8080/veiculo";

  static Future<List<Veiculo>> getAll() async {
    Response res = await get(Uri.parse("$url/getAll"));
    if (res.statusCode == 200) {
      List result = jsonDecode(utf8.decode(res.bodyBytes));
      return result.map((e) => Veiculo.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  static createVeiculo(Veiculo? veiculo) async {
    // print(veiculo!.toMap());
    Response res = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(veiculo!.toMap()));
    print(res.statusCode);
    if (res.statusCode == 201) {
      print("tudo certo!");
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  static updateVeiculo(Veiculo? veiculo) async {
    Response res = await put(Uri.parse(url), body: jsonEncode(veiculo));
    if (res.statusCode == 200) {
      print("tudo certo!");
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  static deleteVeiculo(Veiculo? veiculo) async {
    Response res = await delete(Uri.parse("$url/${veiculo?.id}"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (res.statusCode == 200) {
      print("ok");
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}
