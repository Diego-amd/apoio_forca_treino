import 'package:flutter/material.dart';
import '../../model/aluno.model.dart';
import '../../model/professor.model.dart';

class ProfessorItem extends StatelessWidget {
  final ProfessorModel model;

  ProfessorItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55,
            height: 55,
            margin: EdgeInsets.fromLTRB(0, 5, 8, 0),
            child: CircleAvatar(
                backgroundColor: Color.fromRGBO(6, 32, 41, 2),
                // backgroundImage: NetworkImage(""),
                child: Icon(Icons.person, color: Colors.white)),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.nomeCompleto!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
