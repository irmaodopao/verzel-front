

class Admin{

  String? id;
  String? usuario;
  String? senha;

  Admin({this.id,this.usuario,this.senha});

  factory Admin.fromJson(Map<String,dynamic> json) => Admin(
    id: json["id"],
    usuario: json["usuario"],
    senha: json["senha"],
  );


}