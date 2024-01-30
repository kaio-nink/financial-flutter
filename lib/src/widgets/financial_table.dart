import 'dart:developer';

import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:flutter/material.dart';

late List<FinancialEntity> financials;

class FinancialTable extends StatelessWidget {
  const FinancialTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SqliteHelper().findAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        financials = snapshot.data as List<FinancialEntity>;
        return DataTable(
            columns: const [
              DataColumn(label: Text('Data')),
              DataColumn(label: Text('Descrição')),
              DataColumn(label: Text('Valor')),
            ],
            rows: financials.map((item) => 
            DataRow(
            cells: [
              DataCell(Text(formatDate(item.date))),
              DataCell(Text(item.description)),
              DataCell(Text('R\$ ${item.value}')),
            ],
          )).toList()
            );
      }
    );
  }
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.day}';
}

List<DataRow> generateRow() {
  List<DataRow> data = List.generate(
      financials.length,
      (index) => DataRow(
            cells: [
              DataCell(Text(financials[index].date.toString())),
              DataCell(Text(financials[index].description)),
              DataCell(Text(financials[index].value.toString())),
            ],
          ));
  log(data.length.toString());
  return data;
}

// Future<List<TableRow>> getList() async {
//   var result = await SqliteHelper.listFinancials();
//   List<TableRow>? rows = [];
//   for (var i = 0; i < 10; i++) {
//     rows.add(const TableRow(children: [TableCell(child: Text('teste'))]));
//   }
//   // for (var res in result) {
//   //   for (var item in res.keys) {
//   //     rows.add(
//   //         TableRow(children: [TableCell(child: Text(res[item].toString()))]));
//   //   }
//   // }
//   return rows;
// }
