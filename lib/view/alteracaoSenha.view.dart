import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlteracaoSenha extends StatefulWidget {
  @override
  _AlteracaoSenha createState() => _AlteracaoSenha();
}

var txtsenha1 = 'senha';
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
var documento = '';
var colecao = '';

void recebePrefs(BuildContext context) async {
  final objArgs = (ModalRoute.of(context)?.settings.arguments ??
      <String, dynamic>{}) as Map;
  colecao = objArgs['colecao'];
  documento = objArgs['documento'];
}

TextEditingController camposenha = TextEditingController();
TextEditingController campoconfirmaSenha = TextEditingController();
bool validaSenha() {
  var senha = camposenha.text;
  var senha2 = campoconfirmaSenha.text;
  if (senha == senha2) {
    return true;
  } else {
    return false;
  }
}

class _AlteracaoSenha extends State<AlteracaoSenha> {
  var formKey = GlobalKey<FormState>();
  bool loading = false;

  void changePassword(BuildContext context) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
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
              .update({'senha': camposenha.text});
          switch (colecao) {
            case 'alunos':
              Navigator.of(context).pushReplacementNamed('/homeAluno');
              break;
            case 'professores':
              Navigator.of(context).pushReplacementNamed('/homeProfessor');
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
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    recebePrefs(context);
    return Scaffold(
        body: Form(
      key: formKey,
      child: Container(
        color: Color.fromRGBO(6, 32, 41, 2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Por favor, insira uma nova senha",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
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
                              controller: camposenha,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Campo senha ?? obrigat??rio!";
                                } else if (value.length < 6) {
                                  return "Senha tem que ter mais de 6 caracteres";
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
                                if (value != camposenha.text) {
                                  return "Senha diferente do digitado acima";
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
              loading
                  ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 235, 213, 16))
                  : Container(
                      width: 326,
                      height: 50,
                      margin: EdgeInsets.only(top: 50, bottom: 0, left: 0),
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
      ),
    ));
  }
}
