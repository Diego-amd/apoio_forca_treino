import 'package:flutter/material.dart';
import '../../model/professor.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessorItem extends StatelessWidget {
  final ProfessorModel model;
  final firestore = FirebaseFirestore.instance;

  ProfessorItem(this.model);

  void ExcluirProfessor(BuildContext context) async {
    final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
        firestore
            .collection("professores")
            .where("email", isEqualTo: model.email)
            .get());
    final List<DocumentSnapshot> documents = resultado.docs;

    if (documents.length == 1) {
      firestore.collection("professores").doc(resultado.docs[0].id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55,
            height: 55,
            margin: EdgeInsets.fromLTRB(0, 5, 8, 0),
            child: CircleAvatar(
                backgroundColor: Color.fromRGBO(6, 32, 41, 2),
                // backgroundImage: NetworkImage(""),
                child: Icon(Icons.person, color: Colors.white)),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.nomeCompleto!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
          ),
          IconButton(
            onPressed: () => showDialogAlert(context),
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
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
                "Você deseja realmente excluir o professor: \n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                model.nomeCompleto!.toUpperCase(),
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
                  ExcluirProfessor(context),
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
