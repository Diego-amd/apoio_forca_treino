import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  void CadastrarAluno(BuildContext context) {
    Navigator.of(context).pushNamed('/alunosView');
  }

  void CadastrarProfessor(BuildContext context) {
    Navigator.of(context).pushNamed('/profView');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo Admin!"),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextButton(
                    onPressed: () => CadastrarAluno(context),
                    child: Text("Alunos",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black))),
              ),
              Container(
                child: TextButton(
                    onPressed: () => CadastrarProfessor(context),
                    child: Text("Professores",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black))),
              ),
            ],
          ),
        ));
  }
}
