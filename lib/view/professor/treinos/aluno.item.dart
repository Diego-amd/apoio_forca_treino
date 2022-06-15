import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/aluno.model.dart';

class AlunoItem extends StatelessWidget {
  final AlunoModel model;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  AlunoItem(this.model);

  void selecionaAluno(BuildContext context) async {
    Navigator.of(context)
        .pushNamed('/exercicioTreino', arguments: {'alunoSelecionado': model});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.nomeCompleto!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => selecionaAluno(context),
            icon: const Icon(Icons.add_circle_outlined, size: 30),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
