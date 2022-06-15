import 'package:flutter/material.dart';

class PlanoTreinoResumo extends StatelessWidget {
  const PlanoTreinoResumo({Key? key}) : super(key: key);

  void recebePrefs(BuildContext context) async {
    final objArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    var aluno = objArgs['alunoSelecionado'];
    var exercicios = objArgs['exercicios'];
    var dataInicio = objArgs['dataInicio'];
    var dataFinal = objArgs['dataFinal'];

    print(aluno);
    print(dataFinal);
  }

  @override
  Widget build(BuildContext context) {
    recebePrefs(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(6, 32, 41, 2),
          elevation: 5,
          shadowColor: Color.fromRGBO(6, 32, 41, 2),
          title: Text("Resumo do plano"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Color.fromRGBO(6, 32, 41, 2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 6,
                      blurRadius: 5,
                      offset: Offset(3, 7),
                    )
                  ],
                ),
                child: Text("Informações do aluno"),
              ),
              Text("Exercicios"),
              Text("Datas")
            ],
          ),
        ));
  }
}
