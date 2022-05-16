class ProfessorModel {
  String? nomeCompleto;
  String? email;
  String? senha;
  String? turno;

  ProfessorModel(this.nomeCompleto, this.email, this.senha, this.turno);

  ProfessorModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    email = map["email"];
    senha = map["senhaCad"];
    turno = map["turno"];
  }
}
