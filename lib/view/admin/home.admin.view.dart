import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  void CadastrarAluno(BuildContext context) {
    Navigator.of(context).pushNamed('/alunosView');
  }

  void CadastrarProfessor(BuildContext context) {
    Navigator.of(context).pushNamed('/profView');
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var nomeEmpresa = "Vasco GYM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 25),
                width: 50,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () => renderModalSair(context),
                  child: const CircleAvatar(
                    backgroundImage:
                        ExactAssetImage("images/circleAvatarMulher.png"),
                  ),
                ))
          ],
          title: Container(
            margin: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                const Text("Bem-vindo, ", style: TextStyle(fontSize: 24)),
                Text(
                  nomeEmpresa,
                  style: const TextStyle(fontSize: 24, color: Colors.yellow),
                ),
              ],
            ),
          ),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
          elevation: 15,
          shadowColor: Color.fromRGBO(6, 32, 41, 2)),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => CadastrarAluno(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                          image: AssetImage("images/alunos.png"),
                          fit: BoxFit.fill,
                          opacity: 1),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 65),
                      child: const Text("Alunos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 4,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ],
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 100),
                child: TextButton(
                    onPressed: () => CadastrarProfessor(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                            image: AssetImage("images/professores.jpg"),
                            fit: BoxFit.fitWidth,
                            opacity: 1),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 65),
                        child: const Text("Professores",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(4, 4),
                                    blurRadius: 4,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )
                                ],
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void renderModalSair(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: MediaQuery.of(context).size.height * 0.2,
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
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: TextButton(
                        onPressed: () => {},
                        child: const Text(
                          "Não",
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
