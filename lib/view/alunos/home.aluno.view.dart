import 'package:apoio_forca_treino/view/alunos/aluno.home.view.dart';
import 'package:apoio_forca_treino/view/alunos/conta.aluno.view.dart';
import 'package:apoio_forca_treino/view/alunos/treinos.alunos.view.dart';
import 'package:flutter/material.dart';

//É o BottomNavigationBar contendo as opções de telas
class HomeAluno extends StatefulWidget {
  @override
  _HomeAluno createState() => _HomeAluno();
}

class _HomeAluno extends State<HomeAluno> {
  int _indiceAtual = 0;
  final cor = Color.fromRGBO(6, 32, 41, 2);
  final List<Widget> _telas = [
    AlunoHome(),
    TreinosAluno(),
    ContaAluno(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: cor,
          unselectedIconTheme: IconThemeData(color: Colors.white),
          selectedIconTheme: IconThemeData(color: Colors.yellow),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
          currentIndex: _indiceAtual,
          onTap: mudaIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/academia.png"),
              ),
              label: "Treinos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Minha conta",
            )
          ]),
    );
  }

  void mudaIndex(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
