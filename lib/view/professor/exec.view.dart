import 'package:apoio_forca_treino/view/professor/exec.item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/exercicio.model.dart';

class ExercicioView extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void CadastrarExercicio(BuildContext context) {
    Navigator.of(context).pushNamed('/cadExercicio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("Listagem de exericios"),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
          elevation: 15,
          shadowColor: Color.fromRGBO(6, 32, 41, 2),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection('exercicios')
                .orderBy('tipo')
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              if (snapshot.hasError) return Text("Erro ao carregar os dados");

              if (snapshot.data!.docs.length == 0) {
              return Center(
                  child: Container(
                      child: Text(
                'Nenhum exercicio ainda',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
              )));
            }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int i) => ExercicioItem(
                        ExercicioModel.fromMap(
                            snapshot.data!.docs[i].data()),
                      ));
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 211, 230, 0),
          onPressed: () => CadastrarExercicio(context),
        ));
  }
}
