import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/aluno.model.dart';

String nomeAluno = '';
String nomeInicial = '';
String? docID;

class ContaAluno extends StatefulWidget {
  @override
  _ContaAluno createState() => _ContaAluno();
}

class _ContaAluno extends State<ContaAluno> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        var docID = firestore.collection("alunos").doc(resultado.docs[0].id);
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
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        body: Container(
          width: double.infinity,
          height: 800,
          child: Center(
            child: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 95,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        radius: 90,
                        child: Text(nomeInicial,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 80)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(nomeAluno,
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                        width: 156,
                        height: 50,
                        margin: EdgeInsets.only(top: 70, bottom: 0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 245, 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          child: const Text("Alterar Nome",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          onPressed: () => alterarNome(context),
                        )),
                    Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 20, bottom: 0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 245, 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          child: const Text("Alterar Data de nascimento",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          onPressed: () => alterarDataNascimento(context),
                        )),
                    Container(
                        width: 106,
                        height: 50,
                        margin: EdgeInsets.only(top: 20, bottom: 0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 200, 7, 7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          child: const Text("Logoff",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          onPressed: () => renderModalSair(context),
                        )),
                  ]),
            ),
          ),
        ));
  }

  alterarDataNascimento(BuildContext context) {
    var form = GlobalKey<FormState>();
    var nasc = TextEditingController();

    var dataNasc = nasc;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 5.0),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const Text(
                "Alterar Nome",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                controller: nasc,
                onSaved: (value) => {},
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Data nascimento",
                  icon: Icon(Icons.calendar_month,
                      size: 20, color: Colors.black38),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                style: TextStyle(fontSize: 14),
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
                  'Salvar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  {
                    final dataNasc = FirebaseFirestore.instance
                        .collection('alunos')
                        .doc(docID)
                        .update({
                      'nomeCompleto': nasc.text,
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  alterarNome(BuildContext context) {
    var form = GlobalKey<FormState>();
    var nome = TextEditingController();

    var nomeAluno = nome;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 5.0),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const Text(
                "Alterar Nome",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextFormField(
                key: form,
                decoration: InputDecoration(labelText: 'nome'),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                ),
                controller: nomeAluno,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo não pode ser vazio';
                  }
                  return null;
                },
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
                  'Salvar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  {
                    final nomeAluno = FirebaseFirestore.instance
                        .collection('alunos')
                        .doc(docID)
                        .update({
                      'nomeCompleto': nome.text,
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void renderModalSair(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
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
