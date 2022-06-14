import 'package:apoio_forca_treino/view/professor/cad.treino.view.dart';
import 'package:apoio_forca_treino/view/professor/exec.view.dart';
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
import 'professor/exec.view.dart';
import 'professor/cad.treino.view.dart';
import 'professor/treino.view.dart';

import 'admin/alunos.view.dart';
import 'admin/prof.view.dart';

import 'ponte.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
          '/ponte': (context) => Ponte(),
          '/execView': (context) => ExercicioView(),
          '/cadTreino': (context) => CadastroTreino(),
          '/treinoView': (context) => TreinoView()
        },
        initialRoute: '/ponte');
  }
}
