import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/aluno.model.dart';

class AlunoItem extends StatelessWidget {
  final AlunoModel model;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  AlunoItem(this.model);

  void ExcluirAluno(BuildContext context) async {
    final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
        firestore
            .collection("alunos")
            .where("email", isEqualTo: model.email)
            .get());
    final List<DocumentSnapshot> documents = resultado.docs;

    if (documents.length == 1) {
      print("Documento será apagado:");
      print(resultado.docs[0].id);
      firestore.collection("alunos").doc(resultado.docs[0].id).delete();
    }

    //precisa pegar o id do documento para fazer o delete
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.edit),
            color: Colors.blue,
            tooltip: "Teste",
          ),
          IconButton(
            onPressed: () => showDialogAlert(context),
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
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
                "Você deseja realmente excluir o aluno: \n",
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
                  ExcluirAluno(context),
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
