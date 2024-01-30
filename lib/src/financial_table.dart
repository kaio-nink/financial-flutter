import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:flutter/material.dart';

class FinancialTable extends StatelessWidget {
  const FinancialTable({super.key});

  @override
  Widget build(BuildContext context) {
    var sqliteHelper = SqliteHelper();
    List<FinancialEntity> financials = [];

    sqliteHelper.findAll().then((list) {
      financials = list;
    });
    print(financials);
    return DataTable(
      columns: const [
        DataColumn(label: Text('Data')),
        DataColumn(label: Text('Descrição')),
        DataColumn(label: Text('Valor')),
      ],
      rows: financials
          .map((item) => DataRow(
                cells: [
                  DataCell(Text(item.date.toString())),
                  DataCell(Text(item.description)),
                  DataCell(Text(item.value.toString())),
                ],
              ))
          .toList(),
    );
  }
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
