class AlunoModel {
  String? nomeCompleto;
  String? email = '';
  String? senha = '';
  bool? ativo = true;
  String? sexo = '';

  AlunoModel(this.nomeCompleto, this.email, this.senha, this.ativo, this.sexo);

  AlunoModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    email = map["email"];
    senha = map["senha"];
    ativo = map["ativo"];
    sexo = map["sexo"];
  }
}
