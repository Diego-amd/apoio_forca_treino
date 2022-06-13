import '../view/professor/exec.view.dart';

class ExercicioModel {
  String? nomeExec;
  String? descricaoExec;
  String? tipoExec;

  ExercicioModel(
      this.nomeExec, this.descricaoExec, this.tipoExec);

  ExercicioModel.fromMap(Map<String, dynamic> map) {
    nomeExec = map["nome"];
    descricaoExec = map["descricao"];
    tipoExec = map["tipo"];
  }
}
