import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/treino.model.dart';

class TreinoItem extends StatelessWidget {
  final ExercicioModel model;
  final firestore = FirebaseFirestore.instance;

  TreinoItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
