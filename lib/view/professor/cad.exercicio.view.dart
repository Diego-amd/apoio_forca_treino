import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroExercicio extends StatefulWidget {
  @override
  _CadastroExercicio createState() => _CadastroExercicio();
}

class _CadastroExercicio extends State<CadastroExercicio> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  TextEditingController nome = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  void enviarCadastro(BuildContext context) async {
    var nomeExec = nome.text;
    var descricaoExec = descricao.text;
    var tipoExec = tipo.text;
    var emailText = email.text;
    var senhaText = senha.text;

    emailText = 'professor2@gmail.com';
    senhaText = '123456';

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await firestore.collection('exercicios').add({
        "nome": nomeExec,
        "descricao": descricaoExec,
        "tipo": tipoExec,
        "ativo": true,
        "checked": false,
      });

      await firestore.collection('treinos').add({
        "nomeExercicio": nomeExec,
        "descricaoExercicio": descricaoExec,
        "tipoExercicio": tipoExec,
      });

      Navigator.of(context).pushReplacementNamed('/execView');
    }
  }

  final items = ["Abdomen", "Braço", "Costa", "Ombro", "Peito", "Perna"];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Cadastrar exercicio"),
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 15,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/cadastro.png"),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.6, 1],
                    colors: [
                      Color.fromRGBO(6, 32, 41, 2),
                      Color.fromARGB(0, 32, 41, 2),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                          width: 326,
                          height: 50,
                          padding: EdgeInsets.only(left: 16),
                          margin: EdgeInsets.only(top: 50),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: nome,
                            onSaved: (value) => {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo nome é obrigatório!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nome exercicio",
                              icon: Icon(Icons.account_circle_rounded,
                                  size: 20, color: Colors.black38),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          width: 326,
                          height: 100,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: descricao,
                            onSaved: (value) => {},
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "descrição",
                              icon: Icon(Icons.create_sharp,
                                  size: 20, color: Colors.black38),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          width: 326,
                          height: 48,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: tipo,
                            onSaved: (value) => {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo tipo é obrigatório!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Tipo exercicio",
                              icon: Icon(Icons.check,
                                  size: 20, color: Colors.black38),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Container(
                          width: 326,
                          height: 50,
                          margin: EdgeInsets.only(top: 70, bottom: 0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 245, 10),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            child: const Text("Cadastrar",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            onPressed: () => enviarCadastro(context),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
