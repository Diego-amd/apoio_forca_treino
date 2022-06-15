import 'package:apoio_forca_treino/model/exercicio.model.dart';
import 'package:flutter/material.dart';

class ExercicioItem extends StatelessWidget {
  final ExercicioModel model;

  ExercicioItem(this.model);

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
                  model.tipoExec.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.add_circle_outlined, size: 30),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
