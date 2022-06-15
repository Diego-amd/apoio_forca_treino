import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../model/aluno.model.dart';
import './aluno.item.dart';

class AlunoTreino extends StatelessWidget {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 5,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
        title: Text("Selecione o aluno"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('alunos')
              .where('ativo', isEqualTo: true)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Erro ao carregar os dados",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              );
            }

            return ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) => AlunoItem(
                      AlunoModel.fromMap(snapshot.data!.docs[index].data()),
                    ));
          }),
    );
  }
}
