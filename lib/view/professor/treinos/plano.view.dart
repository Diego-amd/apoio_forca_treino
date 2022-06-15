import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

late DateTime startDate = DateTime.now();
late DateTime endDate = DateTime.now();
var alunoSelecionado;
var exerciciosSelecionados = [];

class PlanoTreino extends StatelessWidget {
  void recebePrefs(BuildContext context) async {
    final objArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    var aluno = objArgs['alunoSelecionado'];
    var exercicios = objArgs['exercicios'];
    alunoSelecionado = aluno;
    exerciciosSelecionados = exercicios;
  }

  void avancaTela(BuildContext context) {
    recebePrefs(context);

    Navigator.of(context).pushNamed('/planoTreinoResumo', arguments: {
      'alunoSelecionado': alunoSelecionado,
      'exercicios': exerciciosSelecionados,
      'dataInicio': startDate,
      'dataFinal': endDate
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        elevation: 5,
        shadowColor: Color.fromRGBO(6, 32, 41, 2),
        title: Text("Selecione as datas do treino"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Selecione o período ativo do treino",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: EdgeInsets.only(left: 16),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 213, 217, 235),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: _onChangedDate,
                rangeSelectionColor: Color.fromARGB(104, 6, 32, 41),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(6, 32, 41, 2),
        onPressed: () => avancaTela(context),
        tooltip: "Avançar",
        child: Icon(Icons.arrow_forward, size: 35),
      ),
    );
  }

  void _onChangedDate(DateRangePickerSelectionChangedArgs args) {
    //sempre entra nesse if nesse modo de picker
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      if (args.value.endDate != null) {
        endDate = args.value.endDate;
      }
      print(startDate);
      print(endDate);
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }
}
