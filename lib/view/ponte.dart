import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Ponte extends StatelessWidget {
  var home = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getPrefs(context) async {
    final prefs = await SharedPreferences.getInstance();
    home = prefs.getInt('tipoUsuario') ?? 0;
    redirecionaHome(context);
    if (auth.currentUser!.uid.isEmpty) {
      home = 0;
    }
  }

  void redirecionaHome(BuildContext context) {
    // 0 = Login
    // 1 = Aluno
    // 2 = Professor
    // 3 = Admin
    // 4 = Primeiro acesso/Alterar senha
    switch (home) {
      // case null:
      //   Navigator.of(context).pushReplacementNamed('/');
      //   break;
      case 0:
        Navigator.of(context).pushReplacementNamed('/');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/homeAluno');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/homeProfessor');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/homeAdmin');
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed('/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    getPrefs(context);

    return Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    );
  }
}
