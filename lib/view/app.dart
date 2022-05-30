import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.view.dart';
import 'alteracaoSenha.view.dart';

import 'admin/home.admin.view.dart';
import 'professor/home.professor.view.dart';
import 'alunos/home.aluno.view.dart';

import 'admin/cad.alunos.view.dart';
import 'admin/cad.professor.view.dart';
import 'professor/cad.exercicio.view.dart';

import 'admin/alunos.view.dart';
import 'admin/prof.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.yellow,
        ),
        routes: {
          '/': (context) => LoginView(),
          '/alterarSenha': (context) => AlteracaoSenha(),
          '/homeAdmin': (context) => HomeAdmin(),
          '/homeAluno': (context) => HomeAluno(),
          '/cadAluno': (context) => CadastroAluno(),
          '/cadProfessor': (context) => CadastroProfessor(),
          '/cadExercicio': (context) => CadastroExercicio(),
          '/homeProfessor': (context) => HomeProfessor(),
          '/alunosView': (context) => AlunoView(),
          '/profView': (context) => ProfessorView(),
        },
        initialRoute: '/');
  }
}
