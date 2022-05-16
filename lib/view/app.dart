import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.view.dart';
import 'alteracaoSenha.view.dart';
import 'home.admin.view.dart';
import 'cad.alunos.view.dart';
import 'cad.professor.view.dart';
import 'homeprofessor.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => LoginView(),
      '/alterarSenha': (context) => AlteracaoSenha(),
      '/homeAdmin': (context) => HomeAdmin(),
      '/cadAluno': (context) => CadastroAluno(),
      '/cadProfessor': (context) => CadastroProfessor(),
      '/homeprofessor': (context) => HomeProfessor()
    }, initialRoute: '/');
  }
}
