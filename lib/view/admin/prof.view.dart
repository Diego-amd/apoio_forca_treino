import 'package:apoio_forca_treino/view/admin/prof.item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/professor.model.dart';

class ProfessorView extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void CadastrarProfessor(BuildContext context) {
    Navigator.of(context).pushNamed('/cadProfessor');
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("Listagem de professores"),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
          elevation: 15,
          shadowColor: Color.fromRGBO(6, 32, 41, 2),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection('professores')
                .orderBy('nomeCompleto')
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              if (snapshot.hasError) return Text("Erro ao carregar os dados");

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) => ProfessorItem(
                        ProfessorModel.fromMap(
                            snapshot.data!.docs[index].data()),
                      ));
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 211, 230, 0),
          onPressed: () => CadastrarProfessor(context),
        ));
  }
}
