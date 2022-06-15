import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoModel {
  String? nomeCompleto;
  Timestamp? dataNasc;
  String? email = '';
  String? senha = '';
  String? altura = '';
  String? peso = '';
  String? sexo = '';

  AlunoModel(this.nomeCompleto, this.dataNasc, this.email, this.senha,
      this.altura, this.peso, this.sexo);

  AlunoModel.fromMap(Map<String, dynamic> map) {
    nomeCompleto = map["nomeCompleto"];
    dataNasc = map["dataNasc"];
    email = map["email"];
    senha = map["senha"];
    altura = map["altura"].toString();
    peso = map["peso"].toString();
    sexo = map["sexo"];
  }
}
