import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class HomeProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            width: 326,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 245, 10),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextButton(
              child: const Text("Sair",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/login'),
            )),
        Container(
            width: 326,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 245, 10),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextButton(
                child: const Text("Logoff",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                })),
               Container(
            width: 326,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 245, 10),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextButton(
                child: const Text("Cadastro Exercicios",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacementNamed('/cadExercicio');
                })) 

      ],
    ));
  }
}
