import 'package:cloud_firestore/cloud_firestore.dart';
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
      appBar: AppBar(
          title: Text("Cadastrar Exercicio",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255))),
          backgroundColor: Color.fromARGB(253, 14, 57, 71)),
      backgroundColor: Color.fromRGBO(6, 32, 41, 2),
      body: StreamBuilder(
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/cadastro.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      'Nenhum exercicio ainda',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    )));
          }
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
                  subtitle: Text(doc['descricao']),
                  trailing: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 233, 233, 233),
                    foregroundColor: Color.fromARGB(255, 211, 230, 0),
                    child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => {                           
                               showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("Exclusão"),
                                  content: Text("Voce deseja realmente excluir este exercicio? Caso não queira, clicar fora da caixa de texto."),
                                  actions: <Widget>[
                                  
                                  TextButton(onPressed: () => doc.reference.update({
                        'excluido': true,
                      }), child: Text('Sim')) 
                                  ]
                              ),
                            ),
                          },
                          
                            
                        ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 211, 230, 0),
        onPressed: () => modalCreate(context),
        tooltip: 'Adicionar novo',
        child: Icon(Icons.add),
      ),
    );
  }

  modalCreate(BuildContext context) {
    var form = GlobalKey<FormState>();
    var nome = TextEditingController();
    var foto = TextEditingController();
    var descricao = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 82, 83, 89),
          title: Text('Criar novo exercicio',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255))),
          content: Form(
            key: form,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nome',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: ('Ex.: Agachamento'),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 255, 3)),
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
                  /*Text('Foto',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  ButtonWidget(
                    text: 'Select File',
                    icon: Icons.attach_file,
                    onClicked: ,
                  ),*/
                  SizedBox(height: 20),
                  Text('Descrição',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 55.0, horizontal: 10.0),
                      hintText: '(Opcional)',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 234, 255, 3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: descricao,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 40,
              width: 100,
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
              width: 100,
              child: TextButton(
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('exercicios')
                        .add({
                      'nome': nome.text,
                      'descricao': descricao.text,
                      'foto': foto.text,
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
