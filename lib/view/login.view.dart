import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = '';
  String senha = '';
  int home = 0;
  String colecao = '';
  String documento = '';
  bool loading = false;
  bool erro = false;
  bool erroSenha = false;
  bool erroUsuario = false;
  String msgUsuario = "";
  String msg = "";
  String msgSenha = "";
  // 0 = Login
  // C = Aluno
  // 2 = Professor
  // 3 = Admin
  // 4 = Primeiro acesso/Alterar senha

  void validaLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    var aluno = await chamarAluno();
    colecao = "alunos";
    if (home == 0) {
      var professor = await chamarProfessor();
      colecao = "professores";
      if (home == 0) {
        var admin = await chamarAdmin();
        colecao = "admin";
      }
    }
    if (home == 1) {
      Navigator.of(context).pushReplacementNamed('/homeAluno');
    } else if (home == 2) {
      Navigator.of(context).pushReplacementNamed('/homeProfessor');
    } else if (home == 3) {
      Navigator.of(context).pushReplacementNamed('/homeAdmin');
    } else if (home == 4) {
      Navigator.of(context).pushReplacementNamed('/alterarSenha',
          arguments: {'colecao': colecao, 'documento': documento});
    } else {
      return print('Usuario não encontrado');
    }
    await prefs.setInt('tipoUsuario', home);
  }

  void save(BuildContext context) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      try {
        formKey.currentState!.save();
        var result = await auth.signInWithEmailAndPassword(
            email: email, password: senha);
      } on FirebaseAuthException catch (e) {
        erroUsuario = true;
        loading = false;
        print('OIEE, DEU ERRO');
        print(e);
        switch (e.code) {
          case 'invalid-email':
            msgUsuario = 'Email invalido';
            break;
          case 'wrong-password':
            msgUsuario = 'Senha incorreta';
            break;
          case 'user-not-found':
            msgUsuario = 'Usuario não encontrado';
            break;
        }
      }
      // Buscar dados
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
      documento = resultado.docs[0].id;
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
      documento = resultado.docs[0].id;
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
      documento = resultado.docs[0].id;
      //Navigator.of(context).pushNamed('/alterarSenha');
      var senha = await resultado.docs[0].data()['senha'];
      var nomeEmpresa = await resultado.docs[0].data()['nomeEmpresa'];
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
    // validaLogin(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/login.png"),
                      fit: BoxFit.fitHeight),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.5, 1],
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
                        margin: EdgeInsets.only(top: 300),
                        child: const Text("A F T",
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: erro ? Border.all(color: Colors.red) : null,
                          ),
                          child: TextFormField(
                            onChanged: (value) => erro = false,
                            onSaved: (value) => email = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                loading = false;
                                erro = true;
                                msg = "Campo e-mail é obrigatório!";
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
                      erro
                          ? Container(
                              margin: EdgeInsets.only(top: 3, bottom: 0),
                              child: Text(msg,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.red,
                                  )),
                            )
                          : SizedBox(height: 0),
                      SizedBox(
                        child: Container(
                          width: 326,
                          height: 50,
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: erroSenha
                                ? Border.all(color: Colors.red)
                                : null,
                          ),
                          child: TextFormField(
                            onChanged: (value) => erroSenha = false,
                            onSaved: (value) => senha = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                loading = false;
                                erroSenha = true;
                                msgSenha = "Campo senha é obrigatório!";
                                return "";
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
                      erroSenha
                          ? Container(
                              margin: EdgeInsets.only(top: 3, bottom: 0),
                              child: Text(msgSenha,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.red,
                                  )),
                            )
                          : SizedBox(height: 0),
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
                      loading
                          ? const CircularProgressIndicator(
                              color: Color.fromARGB(255, 235, 213, 16))
                          : Container(
                              width: 326,
                              height: 50,
                              margin: EdgeInsets.only(top: 35),
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
                      erroUsuario
                          ? Container(
                              margin: EdgeInsets.only(top: 3, bottom: 0),
                              child: Text(msgUsuario,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.red,
                                  )),
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
