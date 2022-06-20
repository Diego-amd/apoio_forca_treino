import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var nomeAluno = "";
var exercicios = [];
var dataInicio;
var dataFinal;
var altura = "";
var peso = "";
var sexo = "";
var email = "";

class TreinosAluno extends StatefulWidget {
  const TreinosAluno({Key? key}) : super(key: key);

  @override
  State<TreinosAluno> createState() => _TreinosAlunoState();
}

class _TreinosAlunoState extends State<TreinosAluno> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getDadosTreino(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    nomeAluno = prefs.getString('nomeAluno') ?? '';
    print(nomeAluno);

    var userAtual = auth.currentUser?.uid ?? 0;
    if (userAtual != 0) {
      final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
          firestore
              .collection("treinos")
              .where('nome', isEqualTo: nomeAluno)
              .where('ativo', isEqualTo: true)
              .get());
      final List<DocumentSnapshot> documents = resultado.docs;

      if (documents.length == 1) {
        print("entrou");
        altura = await resultado.docs[0].data()['altura'];
        peso = await resultado.docs[0].data()['peso'];
        sexo = await resultado.docs[0].data()['sexo'];
        email = await resultado.docs[0].data()['email'];
        exercicios = await resultado.docs[0].data()['exercicios'];
        dataInicio = await resultado.docs[0].data()['dataInicio'].toDate();
        dataFinal = await resultado.docs[0].data()['dataFinal'].toDate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDadosTreino(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Seus treinos"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 15,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
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
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
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
                            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 199, 199, 202),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            width: 200,
                            padding: EdgeInsets.only(left: 16),
                            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 199, 199, 202),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                                icon: Icon(Icons.sports,
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
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
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
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
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
                                    top: 10, left: 5, right: 5, bottom: 10),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 199, 199, 202),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   height: MediaQuery.of(context).size.height * 0.1,
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(10),
                //     ),
                //     border: Border.all(
                //       color: Color.fromRGBO(6, 32, 41, 2),
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.4),
                //         spreadRadius: 6,
                //         blurRadius: 8,
                //         offset: Offset(3, 8),
                //       )
                //     ],
                //   ),
                //   // child: Column(
                //   //   children: [
                //   //     Container(
                //   //       margin: EdgeInsets.only(top: 5),
                //   //       child: const Text(
                //   //         "Início e fim do treino",
                //   //         style: TextStyle(
                //   //             fontSize: 18, fontWeight: FontWeight.w700),
                //   //       ),
                //   //     ),
                //   //     // Row(
                //   //     //   children: [
                //   //     //     Container(
                //   //     //       width: 210,
                //   //     //       padding: EdgeInsets.only(left: 16),
                //   //     //       margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                //   //     //       decoration: const BoxDecoration(
                //   //     //           color: Color.fromARGB(255, 199, 199, 202),
                //   //     //           borderRadius:
                //   //     //               BorderRadius.all(Radius.circular(10))),
                //   //     //       child: TextFormField(
                //   //     //         initialValue:
                //   //     //             DateFormat("dd/MM/yyyy").format(dataInicio),
                //   //     //         readOnly: true,
                //   //     //         onSaved: (value) => {},
                //   //     //         validator: (value) {
                //   //     //           if (value!.isEmpty) {
                //   //     //             return "Campo nome é obrigatório!";
                //   //     //           }
                //   //     //           return null;
                //   //     //         },
                //   //     //         keyboardType: TextInputType.name,
                //   //     //         decoration: const InputDecoration(
                //   //     //           border: InputBorder.none,
                //   //     //           hintText: "Data Inicio",
                //   //     //           icon: Icon(Icons.date_range,
                //   //     //               size: 20, color: Colors.black38),
                //   //     //           labelStyle: TextStyle(
                //   //     //               color: Colors.black,
                //   //     //               fontWeight: FontWeight.w400,
                //   //     //               fontSize: 16),
                //   //     //         ),
                //   //     //         style: TextStyle(
                //   //     //             fontSize: 16, fontWeight: FontWeight.w700),
                //   //     //       ),
                //   //     //     ),
                //   //     //     Container(
                //   //     //       width: 200,
                //   //     //       padding: EdgeInsets.only(left: 16),
                //   //     //       margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                //   //     //       decoration: const BoxDecoration(
                //   //     //           color: Color.fromARGB(255, 199, 199, 202),
                //   //     //           borderRadius:
                //   //     //               BorderRadius.all(Radius.circular(10))),
                //   //     //       child: TextFormField(
                //   //     //         initialValue:
                //   //     //             DateFormat("dd/MM/yyyy").format(dataFinal),
                //   //     //         readOnly: true,
                //   //     //         onSaved: (value) => {},
                //   //     //         validator: (value) {
                //   //     //           if (value!.isEmpty) {
                //   //     //             return "Campo nome é obrigatório!";
                //   //     //           }
                //   //     //           return null;
                //   //     //         },
                //   //     //         keyboardType: TextInputType.name,
                //   //     //         decoration: const InputDecoration(
                //   //     //           border: InputBorder.none,
                //   //     //           hintText: "Data Final",
                //   //     //           icon: Icon(Icons.date_range,
                //   //     //               size: 20, color: Colors.black38),
                //   //     //           labelStyle: TextStyle(
                //   //     //               color: Colors.black,
                //   //     //               fontWeight: FontWeight.w400,
                //   //     //               fontSize: 16),
                //   //     //         ),
                //   //     //         style: TextStyle(
                //   //     //             fontSize: 16, fontWeight: FontWeight.w700),
                //   //     //       ),
                //   //     //     ),
                //   //     //   ],
                //   //     // ),
                //   //   ],
                //   // ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
