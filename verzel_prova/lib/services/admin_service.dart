import 'dart:convert';

import 'package:http/http.dart';
import 'package:verzel_prova/env/environments.dart';
import 'package:verzel_prova/models/admin.dart';

class AdminService {
  static String url = "${Environments.url}/admin";

  static Future<List<Admin>> getAll() async {
    Response res = await get(Uri.parse("$url/getAll"));
    if (res.statusCode == 200) {
      List result = jsonDecode(utf8.decode(res.bodyBytes));
      return result.map((e) => Admin.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}
