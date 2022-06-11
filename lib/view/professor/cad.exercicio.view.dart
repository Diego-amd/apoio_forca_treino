import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
/*import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widget/button.widget.dart';
import '../api/firebase.api.dart';*/

class CadastroExercicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance
        .collection('exercicios')
        .where('excluido', isEqualTo: false)
        .snapshots();
    return Scaffold(
      //Background e appBar

      appBar: AppBar(
          title: Text("Cadastrar Exercicio",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255))),
          backgroundColor: Color.fromARGB(253, 14, 57, 71)),
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
                'Nenhum exercicio ainda',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              )));
            }

            //lista de exercicios exibidos

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                var doc = snapshot.data!.docs[i];
                var value = doc.data;
                print('exercicios/${doc.reference.id}');
                return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(doc['nome']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(doc['descricao']),
                        Text(doc['tipo'],
                            style: TextStyle(
                              fontWeight: FontWeight. bold
                            ),),
                      ],
                    ),

                      //Botão de excluir os exercicios

                      trailing: Wrap( children: <Widget> [
                        
                        CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 233, 233, 233),
                        foregroundColor: Color.fromARGB(255, 11, 20, 80),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  
                                    contentPadding: EdgeInsets.only(top: 5.0),
                                    backgroundColor:
                                        Color.fromARGB(255, 15, 19, 100),
                                    title: Text(
                                      "Altereação de exercicio",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 20),
                                    ),
                                    content: Form(
                                      child: Container(
                                        height: 350,
                                        width: 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Text(doc['nome'],
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
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Este campo não pode ser vazio';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Text(doc['tipo'],
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
                                                hintText: ('Ex.: Costa, Peito, Ombro  '),
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
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 40,
                                            ),
                                            Text(doc['descricao'],
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
                                                contentPadding: const EdgeInsets.symmetric(
                                                    vertical: 35.0, horizontal: 10.0),
                                                hintText: '(Opcional)',
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(255, 255, 255, 255)),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      SizedBox(
                                        child: TextButton(
                                          child: Container(
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 15),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ),
                                      SizedBox(
                                        child: TextButton(
                                            child: Container(
                                              child: Text(
                                                'Salvar',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 15),
                                              ),
                                            ),
                                            onPressed: () async {
                                              {
                                                doc.reference.update({
                                                doc['nome']: doc['nome'],
                                                doc['tipo']: doc['tipo'],
                                                doc['descrição']: doc['descrição'],
                                                'excluido': false,
                                              });

                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                      ),
                                    ]);
                              },
                            
                            ),
                          },
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 233, 233, 233),
                        foregroundColor: Color.fromARGB(255, 224, 0, 0),
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.only(top: 5.0),
                                    backgroundColor:
                                        Color.fromARGB(255, 15, 19, 100),
                                    title: Text(
                                      "Voce deseja realmente excluir este exercicio?",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 20),
                                    ),
                                    content: Text(""),
                                    actions: <Widget>[
                                      SizedBox(
                                        child: TextButton(
                                          child: Container(
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 15),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ),
                                      SizedBox(
                                        child: TextButton(
                                            child: Container(
                                              child: Text(
                                                'Sim',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 15),
                                              ),
                                            ),
                                            onPressed: () async {
                                              doc.reference.update({
                                                'excluido': true,
                                              });

                                              Navigator.of(context).pop();
                                      }),
                                    ),
                                ]);
                              
                              },
                            ),
                          },
                        ),
                      ),
                     ],
                    ),
                ));
              },
            );
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
          title: Text('Criar novo exercicio',
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
                      hintText: ('Ex.: Costa, Peito, Ombro  '),
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
                  Text('Descrição',
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 10.0),
                      hintText: '(Opcional)',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: descricao,
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
