import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: prefer_typing_uninitialized_variables
var alunoSelecionado;

class ExercicioTreino extends StatefulWidget {
  @override
  State<ExercicioTreino> createState() => _ExercicioTreinoState();
}

class _ExercicioTreinoState extends State<ExercicioTreino> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var selecionadas = [];

  void recebePrefs(BuildContext context) async {
    final objArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    var aluno = objArgs['alunoSelecionado'];
    alunoSelecionado = aluno;
  }

  void avancaTela(BuildContext context) async {
    recebePrefs(context);
    var exerciciosSelecionados = selecionadas;
    Navigator.of(context).pushNamed('/planoTreino', arguments: {
      'alunoSelecionado': alunoSelecionado,
      'exercicios': exerciciosSelecionados
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(selecionadas);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 5,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
        title: Text("Selecione os exercícios"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('exercicios')
            .where('ativo', isEqualTo: true)
            // .where('tipo', isEqualTo: 'Ombro')
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao carregar os dados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                title: Text(
                  snapshot.data!.docs[index]['nome'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  snapshot.data!.docs[index]['tipo'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                selectedTileColor: Color.fromARGB(255, 213, 217, 235),
                onLongPress: () {
                  setState(() {
                    (selecionadas.contains(snapshot.data!.docs[index]["nome"])
                        ? selecionadas
                            .remove(snapshot.data!.docs[index]["nome"])
                        : selecionadas.add(snapshot.data!.docs[index]["nome"]));
                  });
                  print(selecionadas);
                },
                // ignore: iterable_contains_unrelated_type
                leading:
                    (selecionadas.contains(snapshot.data!.docs[index]["nome"])
                        ? const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color.fromRGBO(6, 32, 41, 2),
                            child: Icon(Icons.check, color: Colors.green),
                          )
                        : null),
                // ignore: iterable_contains_unrelated_type
                selected:
                    selecionadas.contains(snapshot.data!.docs[index]["nome"]),
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, ___) => Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        onPressed: () => avancaTela(context),
        tooltip: "Avançar",
        child: Icon(Icons.arrow_forward, size: 35),
      ),
    );
  }
}
