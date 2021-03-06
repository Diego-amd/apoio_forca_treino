// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/material/checkbox_list_tile.dart';

// import '../../model/checkbox.model.dart';

// class TreinoView extends StatefulWidget {
//   @override
//   _TreinoView createState() => _TreinoView();
// }

// class _TreinoView extends State<TreinoView> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   final alunos = [CheckBoxState(title: ''), CheckBoxState(title: '')];

//   void CadastrarTreino(BuildContext context) {
//     Navigator.of(context).pushNamed('/cadTreino');
//   }

//   Widget buildCheckbox(CheckBoxState checkbox) => Checkbox(
//         activeColor: Color.fromARGB(255, 59, 31, 143),
//         value: checkbox.value,
//         onChanged: (value) {
//           setState(() {
//             checkbox.value = value!;
//           });
//         },
//       );

//   @override
//   Widget build(BuildContext context) {
//     var snapshots = FirebaseFirestore.instance
//         .collection('alunos')
//         .where('ativo', isEqualTo: true)
//         .snapshots();
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         title: Text("Selecionar Alunos"),
//         backgroundColor: Color.fromRGBO(6, 32, 41, 2),
//         elevation: 15,
//         shadowColor: Color.fromRGBO(6, 32, 41, 2),
//       ),
//       body: Container(
//         child: StreamBuilder(
//           stream: snapshots,
//           builder: (
//             BuildContext context,
//             AsyncSnapshot<QuerySnapshot> snapshot,
//           ) {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.data!.docs.length == 0) {
//               return Center(
//                   child: Container(
//                       child: Text(
//                 'Nenhum aluno ainda',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
//               )));
//             }
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, int i) {
//                 var doc = snapshot.data!.docs[i];
//                 var value = doc.data;
//                 print('alunos/${doc.reference.id}');
//                 return Container(
//                   margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         margin: EdgeInsets.fromLTRB(0, 5, 8, 0),
//                         child: CircleAvatar(
//                             backgroundColor: Color.fromRGBO(6, 32, 41, 2),
//                             // backgroundImage: NetworkImage(""),
//                             child: Icon(Icons.person, color: Colors.white)),
//                       ),
//                       Expanded(
//                         child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 doc['nomeCompleto'],
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ]),
//                       ),
//                       ...alunos.map(buildCheckbox).toList(),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromARGB(255, 211, 230, 0),
//         onPressed: () => CadastrarTreino(context),
//         tooltip: 'Adicionar novo',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
