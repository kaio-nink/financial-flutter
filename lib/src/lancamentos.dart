//import 'package:financial_flutter/src/data/financial_entity.dart';
import 'dart:developer';

import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Lancamentos extends StatefulWidget {
  final String title;
  const Lancamentos({super.key, required this.title});

  @override
  State<Lancamentos> createState() => _LancamentosState();
}

class _LancamentosState extends State<Lancamentos> {
  final _formKey = GlobalKey<FormState>();
  bool checkReceivement = false;
  var sqliteHelper = SqliteHelper();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String description = '';
    double value = 0.0;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text("Data")),
                  keyboardType: TextInputType.datetime,
                  onSaved: (inputDate) {
                    
                  },
                ),
                TextFormField(
                  initialValue: description,
                  onSaved: (inputDescription) {
                    description = inputDescription ?? '';
                  },
                  decoration: const InputDecoration(label: Text("Descrição")),
                ),
                TextFormField(
                  initialValue: value.toString(),
                  onSaved: (inputValue) {
                    value = double.parse(inputValue!);
                  },
                  decoration: const InputDecoration(label: Text("Valor")),
                ),
                CheckboxListTile(
                  title: const Text('Recebimento?*'),
                  value: checkReceivement,
                  onChanged: (inputValue) {
                    setState(() {
                      checkReceivement = inputValue ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const Text('(*) Desmarque caso seja lançamento de pagamento'),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Cancelar')),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            FinancialEntity financialEntity = FinancialEntity(
                                1, date, description, value, checkReceivement);
                           var created = sqliteHelper.create(financialEntity);
                           log(created.toString());
                           var result = sqliteHelper.findAll();
                           log(result.then((value) => value).toString());

                            // try {
                            //   var db = await SqliteHelper.dbConnection();
                            //   await SqliteHelper.createTables(db);
                            //   await SqliteHelper.insertFinancial(db, financialEntity);
                            //   var result = await SqliteHelper.listFinancials(db);
                            //   print(result);
                            //   await SqliteHelper.dbClose(db);
                            // } on Exception catch (e) {
                            //   print(e);
                            // }

                            _dialogBuilder(context, financialEntity);
                          }
                        },
                        child: const Text('Gravar'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, FinancialEntity fin) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: Column(
          children: [
            Text(fin.id.toString()),
            Text(fin.date.toIso8601String()),
            Text(fin.description),
            Text(fin.value.toString()),
            Text(fin.receivement.toString())
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
