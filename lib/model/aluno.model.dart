class AlunoModel {
  String? nomeCompleto;
  DateTime? datanasc;
  String? email = '';
  String? senha = '';
  num? altura = 0.0;
  num? peso = 0.0;
  String? sexo = '';

  AlunoModel(this.nomeCompleto, this.datanasc, this.email, this.senha,
      this.altura, this.peso, this.sexo);

  AlunoModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    datanasc = map["datanasc"];
    email = map["email"];
    senha = map["senha"];
    altura = map["altura"];
    peso = map["peso"];
    sexo = map["sexo"];
  }
}
