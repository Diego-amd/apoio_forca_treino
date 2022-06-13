import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CadastroTreino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance
        .collection('treinos')
        .where('excluido', isEqualTo: false)
        .snapshots();
    return Scaffold(
      //Background e appBar

      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Cadastrar treino"),
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 15,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/cadastrod.png"), fit: BoxFit.fill),
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

        //Backend cadastro de exercicios

        child: StreamBuilder(
          stream: snapshots,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.length == 0) {
              return Center(
                  child: Container(
                      child: Text(
                'Nenhum treino ainda',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              )));
            }

            return Center(
              child: Text('eu ai'),
            );

            //lista de exercicios exibidos
          },
        ),
      ),

      //Botão de adcionar exercicio

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 211, 230, 0),
        onPressed: () => modalCreate(context),
        tooltip: 'Adicionar novo',
        child: Icon(Icons.add),
      ),
    );
  }

  //Modal do cadastro de exercicio

  modalCreate(BuildContext context) {
    var form = GlobalKey<FormState>();
    var nome = TextEditingController();
    var foto = TextEditingController();
    var descricao = TextEditingController();
    var tipo = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          backgroundColor: Color.fromARGB(255, 28, 37, 90),
          title: Text('Criar novo treino',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255))),

          //Caixas de texto Modal

          content: Form(
            key: form,
            child: Container(
              height: 350,
              width: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('Nome',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: ('Ex.: Agachamento'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: nome,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo não pode ser vazio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Tipo',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo não pode ser vazio';
                      }
                      return null;
                    },
                    controller: tipo,
                  ),
                  SizedBox(
                    height: 20,
                    width: 40,
                  ),
                  
                ],
              ),
            ),
          ),

          //Botões do Modal

          actions: <Widget>[
            SizedBox(
              height: 40,
              width: 125,
              child: TextButton(
                child: Container(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 234, 255, 0)),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              height: 40,
              width: 125,
              child: TextButton(
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('exercicios')
                        .add({
                      'nome': nome.text,
                      'descricao': descricao.text,
                      'foto': foto.text,
                      'tipo': tipo.text,
                      'excluido': false,
                    });

                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 234, 255, 0)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
