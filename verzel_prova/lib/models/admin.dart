

class Admin{

  String? id;
  String? login;
  String? senha;

  Admin({this.id,this.login,this.senha});

  factory Admin.fromJson(Map<String,dynamic> json) => Admin(
    id: json["id"],
    login: json["login"],
    senha: json["senha"],
  );

  Map<dynamic, dynamic> toMapWithoutId() {
    return {
      'login': login,
      'senha': senha
    };
  }


}