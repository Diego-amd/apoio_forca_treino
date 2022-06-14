import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContaAluno extends StatelessWidget {
  const ContaAluno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Text("Entrou na conta do aluno"),
      ),
    );
  }
}
