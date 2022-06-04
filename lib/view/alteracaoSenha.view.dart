import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

var txtsenha1 = 'senha';
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
var documento = '';
var colecao = '';

void recebePrefs(BuildContext context) async {
  final objArgs = (ModalRoute.of(context)?.settings.arguments ??
      <String, dynamic>{}) as Map;
  print('heiter');
  colecao = objArgs['colecao'];
  documento = objArgs['documento'];
  print(documento);
  print(colecao);
}

TextEditingController camposenha = TextEditingController();
TextEditingController campoconfirmaSenha = TextEditingController();
bool validaSenha() {
  var senha = camposenha.text;
  var senha2 = campoconfirmaSenha.text;
  print(senha);
  print(senha2);
  if (senha == senha2) {
    return true;
  } else {
    return false;
  }
}

class AlteracaoSenha extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  void changePassword(BuildContext context) async {
    if (validaSenha()) {
      var newPassword = camposenha.text;
      final user = await FirebaseAuth.instance.currentUser;
      final cred =
          EmailAuthProvider.credential(email: user!.email!, password: '123456');

      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          //Success, do something
          firestore
              .collection(colecao.toString())
              .doc(documento.toString())
              .update({'senha': camposenha.text})
              .then((_) => print('deu certo'))
              .catchError((error) => print('DEU TUDO ERRADO AAAAAAAA'));
          switch (colecao) {
            case 'alunos':
              Navigator.of(context).pushReplacementNamed('/homeAluno');
              break;
            case 'professores':
              Navigator.of(context).pushReplacementNamed('/homeProfessores');
              break;
            case 'admin':
              Navigator.of(context).pushReplacementNamed('/homeAdmin');
              break;
          }
        }).catchError((error) {
          //Error, show something
        });
      }).catchError((err) {});
    } else {
      print('Não passei');
    }
  }

  @override
  Widget build(BuildContext context) {
    recebePrefs(context);
    return Scaffold(
        appBar: AppBar(
            title: Text("Primeiro Acesso"),
            backgroundColor: Color.fromRGBO(6, 32, 41, 2)),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/cadastro.png"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.6, 1],
                      colors: [
                        Color.fromRGBO(6, 32, 41, 2),
                        Color.fromARGB(0, 32, 41, 2),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Container(
                              width: 326,
                              height: 50,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(left: 16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: camposenha,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo senha é obrigatório!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Senha",
                                  icon: Icon(Icons.lock,
                                      size: 20, color: Colors.black38),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              width: 326,
                              height: 50,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(left: 16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: campoconfirmaSenha,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo senha é obrigatório!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirmar Senha",
                                  icon: Icon(Icons.lock,
                                      size: 20, color: Colors.black38),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                    width: 326,
                    height: 50,
                    margin: EdgeInsets.only(top: 160, bottom: 0, left: 35),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 245, 10),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                      child: const Text("Acessar",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      onPressed: () => changePassword(context),
                    )),
              ],
            ),
          ),
        ));
  }
}
