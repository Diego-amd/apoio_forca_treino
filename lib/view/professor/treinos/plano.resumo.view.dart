import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

var aluno;
var exercicios;
var dataInicio;
var dataFinal;
bool loading = false;

class PlanoTreinoResumo extends StatefulWidget {
  @override
  State<PlanoTreinoResumo> createState() => _PlanoTreinoResumoState();
}

class _PlanoTreinoResumoState extends State<PlanoTreinoResumo> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var nomeAluno;
  var altura;
  var peso;
  var sexo;
  var email;
  var sucesso = false;

  void recebePrefs() async {
    final objArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    aluno = objArgs['alunoSelecionado'];
    exercicios = objArgs['exercicios'];
    dataInicio = objArgs['dataInicio'];
    dataFinal = objArgs['dataFinal'];

    nomeAluno = aluno.nomeCompleto;
    altura = aluno.altura;
    peso = aluno.peso;
    sexo = aluno.sexo;
    email = aluno.email;
  }

  void enviaTreino(BuildContext context) async {
    setState(() {
      loading = true;
    });

    var result;
    try {
      await firestore.collection('treinos').add({
        "nome": nomeAluno,
        "altura": altura,
        "peso": peso,
        "sexo": sexo,
        "exercicios": exercicios,
        "dataInicio": dataInicio,
        "dataFinal": dataFinal,
        "ativo": true,
        "uid": auth.currentUser!.uid,
      });

      setState(() {
        loading = false;
        sucesso = true;
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void voltaHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/homeProfessor', (Route<dynamic> route) => false);
  }

  TextEditingController nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    recebePrefs();
    print(nomeAluno);
    return Scaffold(
        appBar: sucesso
            ? null
            : AppBar(
                toolbarHeight: 80,
                backgroundColor: Color.fromRGBO(6, 32, 41, 2),
                elevation: 5,
                shadowColor: Color.fromRGBO(6, 32, 41, 2),
                title: Text("Resumo do plano"),
              ),
        body: sucesso
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_done_outlined,
                        size: 200, color: Colors.blue),
                    const Text(
                      "Treino cadastrado com sucesso!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 245, 221, 9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => voltaHome(),
                        child: const Text(
                          "Voltar para Home",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color.fromRGBO(6, 32, 41, 2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 6,
                              blurRadius: 8,
                              offset: Offset(3, 5),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                "Informações do aluno",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              margin:
                                  EdgeInsets.only(top: 10, left: 5, right: 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 199, 199, 202),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                initialValue: nomeAluno,
                                readOnly: true,
                                onSaved: (value) => {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo nome é obrigatório!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nome completo",
                                  icon: Icon(Icons.account_circle_rounded,
                                      size: 20, color: Colors.black38),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 210,
                                  padding: EdgeInsets.only(left: 16),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 199, 199, 202),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextFormField(
                                    initialValue: altura,
                                    readOnly: true,
                                    onSaved: (value) => {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Campo nome é obrigatório!";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Altura",
                                      icon: Icon(Icons.height_rounded,
                                          size: 20, color: Colors.black38),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 16),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 199, 199, 202),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextFormField(
                                    initialValue: peso,
                                    readOnly: true,
                                    onSaved: (value) => {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Campo nome é obrigatório!";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Peso",
                                      icon: Icon(Icons.account_circle_rounded,
                                          size: 20, color: Colors.black38),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              margin:
                                  EdgeInsets.only(top: 10, left: 5, right: 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 199, 199, 202),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                initialValue: sexo,
                                readOnly: true,
                                onSaved: (value) => {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo nome é obrigatório!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Sexo",
                                  icon: Icon(Icons.person,
                                      size: 20, color: Colors.black38),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              margin:
                                  EdgeInsets.only(top: 10, left: 5, right: 5),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 199, 199, 202),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                initialValue: email,
                                readOnly: true,
                                onSaved: (value) => {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo nome é obrigatório!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  icon: Icon(Icons.email,
                                      size: 20, color: Colors.black38),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        // height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color.fromRGBO(6, 32, 41, 2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 6,
                              blurRadius: 8,
                              offset: Offset(3, 8),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Exercicios",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: exercicios.length,
                                  itemBuilder: (_, index) {
                                    print(exercicios[index]);
                                    return Container(
                                      padding: EdgeInsets.only(left: 16),
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 5,
                                          right: 5,
                                          bottom: 10),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 199, 199, 202),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextFormField(
                                        initialValue: exercicios[index],
                                        readOnly: true,
                                        onSaved: (value) => {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Campo nome é obrigatório!";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          icon: ImageIcon(
                                            AssetImage("images/academia.png"),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color.fromRGBO(6, 32, 41, 2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 6,
                              blurRadius: 8,
                              offset: Offset(3, 8),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: const Text(
                                "Início e fim do treino",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 210,
                                  padding: EdgeInsets.only(left: 16),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 199, 199, 202),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextFormField(
                                    initialValue: DateFormat("dd/MM/yyyy")
                                        .format(dataInicio),
                                    readOnly: true,
                                    onSaved: (value) => {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Campo nome é obrigatório!";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Data Inicio",
                                      icon: Icon(Icons.date_range,
                                          size: 20, color: Colors.black38),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 16),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 199, 199, 202),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextFormField(
                                    initialValue: DateFormat("dd/MM/yyyy")
                                        .format(dataFinal),
                                    readOnly: true,
                                    onSaved: (value) => {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Campo nome é obrigatório!";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Data Final",
                                      icon: Icon(Icons.date_range,
                                          size: 20, color: Colors.black38),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      loading
                          ? const CircularProgressIndicator(
                              color: Color.fromARGB(255, 235, 213, 16))
                          : Container(
                              margin: EdgeInsets.only(top: 30),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 245, 221, 9),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => enviaTreino(context),
                                child: const Text(
                                  "Finalizar",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ));
  }
}
