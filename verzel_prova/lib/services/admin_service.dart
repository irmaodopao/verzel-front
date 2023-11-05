import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  static Future<dynamic> login(Admin? adm) async {
    final prefs = await SharedPreferences.getInstance();
    Response res = await post(
      Uri.parse("$url/login"),
      body: jsonEncode(adm!.toMapWithoutId()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var jsonResponse = jsonDecode(res.body);
    prefs.setString("token", jsonResponse["token"]);
    return res.statusCode;
  }

  

}
