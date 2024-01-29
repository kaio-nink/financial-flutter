// import 'dart:js_interop_unsafe';

// import 'package:financial_flutter/src/data/sqlite_helper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class FinancialTable extends StatelessWidget {
//   const FinancialTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<TableRow> tableList = [];
//     getList().then((value) => tableList = value);
//     return DataTable(columns: [
//       DataColumn(label: Text('Data')),
//       DataColumn(label: Text('Descrição')),
//       DataColumn(label: Text('Valor')),
//       ], 
//       rows: tableList.map<DataRow>((rows) {
//       for(row in rows) {

//       }DataRow(cells: [

//       ])
//       }
//       )
//       )
//   }
// }

// Future<List<TableRow>> getList() async {
//   var result = await SqliteHelper.listFinancials();
//   List<TableRow>? rows = [];
//   for (var i = 0; i < 10; i++) {
//     rows.add(TableRow(children: [TableCell(child: Text('teste'))]));
//   }
//   // for (var res in result) {
//   //   for (var item in res.keys) {
//   //     rows.add(
//   //         TableRow(children: [TableCell(child: Text(res[item].toString()))]));
//   //   }
//   // }
//   return rows;
// }
