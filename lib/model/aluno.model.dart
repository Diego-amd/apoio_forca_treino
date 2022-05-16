class AlunoModel {
  String nomeCompleto = '';
  String email = '';
  String senha = '';
  String teste = null;

  AlunoModel(this.nomeCompleto, this.email, this.senha);

  AlunoModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    email = map["email"];
    senha = map["senha"];
  }
}
