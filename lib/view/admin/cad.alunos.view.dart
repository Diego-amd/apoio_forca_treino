import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroAluno extends StatefulWidget {
  @override
  _CadastroAlunoState createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  bool loading = false;

  int checkedSexo = -1;

  TextEditingController nome = TextEditingController();
  TextEditingController datanasc = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController altura = TextEditingController();
  TextEditingController peso = TextEditingController();

  var erro = false;
  var sucesso = true;
  var msgErro = '';

  void enviarCadastro(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var nomeText = nome.text;
    var emailText = email.text;
    var datanascText = datanasc.text;
    var senhaText = '123456';
    var alturaText = altura.text;
    var pesoText = peso.text;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result;
      sucesso = true;
      try {
        result = await auth.createUserWithEmailAndPassword(
            email: emailText, password: senhaText);
      } on FirebaseAuthException catch (e) {
        erro = true;
        sucesso = false;
        setState(() {
          loading = false;
        });
        switch (e.code) {
          case 'email-already-in-use':
            msgErro = 'Email Já utilizado';
            break;
        }
      }
      if (sucesso) {
        erro = false;
        await result.user!.updateDisplayName(nomeText);

        await firestore.collection('alunos').add({
          "nomeCompleto": nomeText,
          "datanasc": datanascText,
          "email": emailText,
          "senha": senhaText,
          "ativo": true,
          "sexo": checkedSexo == 1 ? "Feminino" : "Masculino",
          "altura": alturaText,
          "peso": pesoText,
          "uid": result.user!.uid,
        });

        Navigator.of(context).pushReplacementNamed('/homeAdmin');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Cadastrar aluno"),
          backgroundColor: Color.fromRGBO(6, 32, 41, 2)),
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
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nome completo",
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
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: email,
                            onSaved: (value) => {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo e-mail é obrigatório!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                              icon: Icon(Icons.email,
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
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: datanasc,
                            onSaved: (value) => {},
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Data nascimento",
                              icon: Icon(Icons.calendar_month,
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
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            initialValue: '123456',
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo senha é obrigatório!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Senha",
                              icon: Icon(Icons.lock,
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
                            height: 50,
                            margin: EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListTile(
                              title: Text("Feminino"),
                              leading: Radio(
                                activeColor: Color.fromRGBO(6, 32, 41, 2),
                                value: 1,
                                groupValue: checkedSexo,
                                onChanged: (valor) {
                                  setState(() {
                                    checkedSexo = 1;
                                  });
                                },
                              ),
                            )),
                      ),
                      SizedBox(
                        child: Container(
                            width: 326,
                            height: 50,
                            margin: EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListTile(
                              title: Text("Masculino"),
                              leading: Radio(
                                activeColor: Color.fromRGBO(6, 32, 41, 2),
                                value: 2,
                                groupValue: checkedSexo,
                                onChanged: (valor) {
                                  setState(() {
                                    checkedSexo = 2;
                                  });
                                },
                              ),
                            )),
                      ),
                      SizedBox(
                        child: Container(
                          width: 326,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: altura,
                            onSaved: (value) => {},
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Altura, Ex: 1,75",
                              icon: Icon(Icons.height,
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
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: peso,
                            onSaved: (value) => {},
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Peso, Ex: 75",
                              icon: Icon(Icons.sports,
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
                      loading
                          ? const CircularProgressIndicator(
                              color: Color.fromARGB(255, 235, 213, 16))
                          : Container(
                              width: 326,
                              height: 50,
                              margin: EdgeInsets.only(top: 30, bottom: 0),
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
                      erro
                          ? Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(msgErro,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  )),
                            )
                          : SizedBox(height: 0),
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
