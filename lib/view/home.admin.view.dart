import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  void CadastrarAluno(BuildContext context) {
    Navigator.of(context).pushNamed('/cadAluno');
  }

  void CadastrarProfessor(BuildContext context) {
    Navigator.of(context).pushNamed('/cadProfessor');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo Admin!"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextButton(
                    onPressed: () => CadastrarAluno(context),
                    child: Text("Cadastrar aluno",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black))),
              ),
              Container(
                child: TextButton(
                    onPressed: () => CadastrarProfessor(context),
                    child: Text("Cadastrar professor",
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
