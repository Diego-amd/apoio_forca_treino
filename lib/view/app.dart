import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.view.dart';
import 'alteracaoSenha.view.dart';

import 'home.admin.view.dart';
import 'homeprofessor.dart';
import 'home.aluno.view.dart';

import 'cad.alunos.view.dart';
import 'cad.professor.view.dart';
import 'cad.exercicio.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => LoginView(),
      '/alterarSenha': (context) => AlteracaoSenha(),
      '/homeAdmin': (context) => HomeAdmin(),
      '/homeAluno': (context) => HomeAluno(),
      '/cadAluno': (context) => CadastroAluno(),
      '/cadProfessor': (context) => CadastroProfessor(),
      '/cadExercicio': (context) => CadastroExercicio(),
      '/homeprofessor': (context) => HomeProfessor()
    }, initialRoute: '/');
  }
}
