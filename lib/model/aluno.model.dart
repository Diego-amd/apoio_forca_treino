import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoModel {
  String? nomeCompleto;
  String? email = '';
  String? senha = '';
  String? altura = '';
  String? peso = '';
  String? sexo = '';

  AlunoModel(this.nomeCompleto, this.email, this.senha, this.altura, this.peso,
      this.sexo);

  AlunoModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    email = map["email"];
    senha = map["senha"];
    altura = map["altura"].toString();
    peso = map["peso"].toString();
    sexo = map["sexo"];
  }
}
