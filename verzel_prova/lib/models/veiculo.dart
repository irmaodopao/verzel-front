

class Veiculo{

  String? id;
  String? nome;
  String? marca;
  String? modelo;
  double? valor;
  String? foto;

  Veiculo({this.id,this.nome,this.marca,this.modelo,this.valor,this.foto});

  factory Veiculo.fromJson(Map<String,dynamic> json) => Veiculo(
    id: json["id"],
    nome: json["nome"],
    marca: json["marca"],
    modelo: json["modelo"],
    valor: json["valor"],
    foto: json["foto"],
  );

   Map<dynamic, dynamic> toMapWithoutId() {
    return {
      'nome': nome,
      'marca': marca,
      'modelo': modelo,
      'valor':valor,
      'foto':foto
    };
  }

  Map<dynamic, dynamic> toMapWithId() {
    return {
      'id' : id,
      'nome': nome,
      'marca': marca,
      'modelo': modelo,
      'valor':valor,
      'foto':foto
    };
  }


}