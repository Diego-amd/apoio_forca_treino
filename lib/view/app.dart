import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.view.dart';
import 'alteracaoSenha.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => LoginView(),
      '/alterarSenha': (context) => AlteracaoSenha(),
    }, initialRoute: '/');
  }
}
