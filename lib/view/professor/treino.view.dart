import 'package:apoio_forca_treino/view/professor/treino.item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/treino.model.dart';

class TreinoView extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void CadastrarExercicio(BuildContext context) {
    Navigator.of(context).pushNamed('/cadTreino');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("Listagem de treinos"),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
          elevation: 15,
          shadowColor: Color.fromRGBO(6, 32, 41, 2),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore.collection('treinos').orderBy('nome').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              if (snapshot.hasError) return Text("Erro ao carregar os dados");

              if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Container(
                        child: Text(
                  'Nenhum treino ainda',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                )));
              }

              return Container(
                child: Text(''),
              );
            }));
  }
}
