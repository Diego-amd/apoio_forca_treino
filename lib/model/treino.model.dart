import '../view/professor/treino.view.dart';

class TreinoModel {
  String? nomeTreino;
  String? nomeExercicio;
  String? descricaoExercicio;
  String? tipoExercicio;

  TreinoModel(this.nomeTreino, this.nomeExercicio,
      this.descricaoExercicio, this.tipoExercicio);

  TreinoModel.fromMap(Map<String, dynamic> map) {
    nomeTreino = map["nomeTreino"];

    nomeExercicio = map["nomeExercicio"];
    descricaoExercicio = map["descricaoExercicio"];
    tipoExercicio = map["tipoExercicio"];
  }
}
