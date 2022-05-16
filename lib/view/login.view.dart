import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = '';
  String senha = '';
  int home = 0;

  void validaLogin(BuildContext context) async {
    var aluno = await chamarAluno();
    if (home == 0) {
      var professor = await chamarProfessor();
      if (home == 0) {
        var admin = await chamarAdmin();
      }
    }
    if (home == 1) {
      Navigator.of(context).pushNamed('/homealuno');
    } else if (home == 2) {
      Navigator.of(context).pushNamed('/homeprofessor');
    } else if (home == 3) {
      Navigator.of(context).pushNamed('/homeadmin');
    } else if (home == 4) {
      Navigator.of(context).pushNamed('/alterarSenha');
    } else {
      return print('Usuario não encontrado');
    }
  }

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      // Buscar dados
      print(home);
      validaLogin(context);
    }
  }

  chamarProfessor() async {
    print('Entrou Professor');
    final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
        firestore
            .collection("professores")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .get());

    final List<DocumentSnapshot> documents = resultado.docs;

    if (documents.length == 1) {
      //Navigator.of(context).pushNamed('/alterarSenha');
      var senha = await resultado.docs[0].data()['senha'];
      if (senha == '123456') {
        print(senha);
        return home = 4;
      } else {
        return home = 2;
      }
    }
    return home = 0;
  }

  chamarAluno() async {
    print('Entrou Aluno');
    final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
        firestore
            .collection("alunos")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .get());

    final List<DocumentSnapshot> documents = resultado.docs;

    if (documents.length == 1) {
      //Navigator.of(context).pushNamed('/alterarSenha');
      var senha = await resultado.docs[0].data()['senha'];
      if (senha == '123456') {
        return home = 4;
      } else {
        return home = 1;
      }
    }
    return home = 0;
  }

  chamarAdmin() async {
    print('Entrou Admin');
    final QuerySnapshot<Map<String, dynamic>> resultado = await Future.value(
        firestore
            .collection("admin")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .get());

    final List<DocumentSnapshot> documents = resultado.docs;
    if (documents.length == 1) {
      //Navigator.of(context).pushNamed('/alterarSenha');
      var senha = await resultado.docs[0].data()['senha'];
      if (senha == '123456') {
        return home = 4;
      } else {
        return home = 3;
      }
    }
    return home = 0;
  }

  @override
  Widget build(BuildContext context) {
    validaLogin(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/login.png"), fit: BoxFit.fill),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.4, 1],
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
                    Container(
                      margin: EdgeInsets.only(top: 200),
                      child: const Text("APOIO DE FORÇA AO TREINO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      child: Container(
                        width: 326,
                        height: 50,
                        margin: EdgeInsets.only(top: 31),
                        padding: EdgeInsets.only(left: 16),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          // autofocus: true,
                          onSaved: (value) => email = value!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo e-mail é obrigatório!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "E-mail",
                            icon: Icon(Icons.email,
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          onSaved: (value) => senha = value!,
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
                    Container(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        child: TextButton(
                          onPressed: () => {},
                          child: const Text("Esqueceu a senha?",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                    Container(
                        width: 326,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 245, 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          child: const Text("Entrar",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          onPressed: () => save(context),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
