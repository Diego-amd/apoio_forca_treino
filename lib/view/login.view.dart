import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // await auth.createUserWithEmailAndPassword(email: email, password: senha);
      var result =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      // result.user!.updateDisplayName(displayName)

      Navigator.of(context).pushNamed('/mensagens');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/login.png")),
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(6, 32, 41, 2),
                      Color.fromARGB(0, 32, 41, 2),
                    ],
                  )),
                ),
              ),
              const SizedBox(
                  child: Text("BODY GOALS WORKOUT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      )))
            ],
          )),
      // body: Form(
      //   key: formKey,
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         onSaved: (value) => email = value!,
      //         validator: (value) {
      //           if (value!.isEmpty) {
      //             return "Campo e-mail obrigatório";
      //           }
      //           return null;
      //         },
      //       ),
      //       TextFormField(
      //         obscureText: true,
      //         onSaved: (value) => senha = value!,
      //         validator: (value) {
      //           if (value!.isEmpty) {
      //             return "Campo senha obrigatório";
      //           }
      //           return null;
      //         },
      //       ),
      //       ElevatedButton(
      //         onPressed: () => save(context),
      //         child: Text("Entrar"),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pushNamed('/register');
      //         },
      //         child: Text("Registrar"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
