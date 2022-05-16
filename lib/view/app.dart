import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.view.dart';
import 'alteracaoSenha.view.dart';
import 'homeprofessor.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: auth.currentUser == null ? LoginView() : LoginView(),
        routes: {
          '/login': (context) => LoginView(),
          '/homeprofessor': (context) => HomeProfessor(),
          '/alterarSenha': (context) => AlteracaoSenha(),
        },
        initialRoute: '/');
  }
}
