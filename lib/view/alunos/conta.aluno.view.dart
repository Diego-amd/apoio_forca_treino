import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/aluno.model.dart';

String nomeAluno = '';
String nomeInicial = '';

class ContaAluno extends StatefulWidget {
  @override
  _ContaAluno createState() => _ContaAluno();
}

class _ContaAluno extends State<ContaAluno> {
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

  void AlterarSenha(BuildContext context) {
    Navigator.of(context).pushNamed('/alterarSenha');
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
                          onPressed: () => modalCreate(context),
                        )),
                    Container(
                        width: 156,
                        height: 50,
                        margin: EdgeInsets.only(top: 20, bottom: 0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 245, 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          child: const Text("Alterar Senha",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          onPressed: () => AlterarSenha(context),
                        )),
                  ]),
            ),
          ),
        ));
  }

  modalCreate(BuildContext context) {
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
                  color: Colors.red,
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
                        .doc()
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
}
