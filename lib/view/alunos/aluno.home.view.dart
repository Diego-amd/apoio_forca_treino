import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String nomeAluno = '';
String nomeInicial = '';

//É a tela de home do aluno que o BottomNavigationBar chama
class AlunoHome extends StatefulWidget {
  @override
  _AlunoHome createState() => _AlunoHome();
}

class _AlunoHome extends State<AlunoHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final cor = Color.fromRGBO(6, 32, 41, 2);

  getDadosFirebase() async {
    var userAtual = auth.currentUser?.uid ?? 0;
    if (userAtual != 0) {
      final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
          firestore
              .collection("alunos")
              .where('uid', isEqualTo: auth.currentUser!.uid)
              .get());
      final List<DocumentSnapshot> documents = resultado.docs;

      if (documents.length == 1) {
        nomeAluno = await resultado.docs[0].data()['nomeCompleto'];
        nomeInicial = nomeAluno[0].toUpperCase();

        if (this.mounted) {
          setState(() {
            nomeAluno = nomeAluno;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDadosFirebase();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              width: 50,
              child: FloatingActionButton(
                tooltip: "Sair",
                backgroundColor: Colors.yellow,
                focusElevation: 2,
                onPressed: () => renderModalSair(context),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  radius: 22,
                  child: Text(nomeInicial,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)),
                ),
              ))
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("\rOlá, ", style: TextStyle(fontSize: 16)),
                Text(
                  nomeAluno.toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.yellow),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: const Text("\rBora começar o treino?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 0,
      ),
      body: Container(
        color: cor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 170, left: 23),
              child: const Text(
                "Professores Disponíveis",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 290, left: 23),
              child: const Text(
                "Exercícios",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void renderModalSair(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(6, 32, 41, 2),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Deseja sair do aplicativo?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 70,
                      margin: const EdgeInsets.only(
                          left: 0, top: 30, right: 25, bottom: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color.fromRGBO(6, 32, 41, 2)),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Não",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(6, 32, 41, 2)),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 70,
                      margin: const EdgeInsets.only(
                          left: 25, top: 30, right: 25, bottom: 25),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(6, 32, 41, 2),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: TextButton(
                        onPressed: () => {
                          auth.signOut(),
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false),
                        },
                        child: const Text("Sim",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
