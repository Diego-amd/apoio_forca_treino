import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreinosAluno extends StatelessWidget {
  const TreinosAluno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 32, 41, 2),
      body: Container(
        color: Colors.white,
        child: Text("Entrou nos treinos dos alunos"),
      ),
    );
  }
}
