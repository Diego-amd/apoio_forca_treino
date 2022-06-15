import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/exercicio.model.dart';

class ExercicioItem extends StatelessWidget {
  final ExercicioModel model;
  final firestore = FirebaseFirestore.instance;

  ExercicioItem(this.model);

  void ExcluirExercicio(BuildContext context) async {
    await firestore
        .collection('treinos')
        .doc('document_id')
        .update({'excluido': true});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
        child: ListTile(
          title: Text(
            model.nomeExec!.toUpperCase(),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.tipoExec!.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Wrap(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Color.fromARGB(255, 16, 18, 135),
                onPressed: (null),
              ),
              IconButton(
                onPressed: () => showDialogAlert(context),
                icon: const Icon(Icons.delete),
                color: Color.fromARGB(255, 219, 40, 27),
              )
            ],
          ),
        ));
  }

  void showDialogAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 5.0),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const Text(
                "Você deseja realmente excluir o exercicio: \n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                model.nomeExec!.toUpperCase(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: TextButton(
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: TextButton(
                child: const Text(
                  'Sim',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => {
                  ExcluirExercicio(context),
                  Navigator.of(context).pop(),
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
