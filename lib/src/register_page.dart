//import 'package:financial_flutter/src/data/financial_entity.dart';
import 'dart:developer';

import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final String title;
  const Register({super.key, required this.title});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool checkReceivement = true;
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
                    var splittedDate = inputDate!.split('/');
                    date = DateTime(
                      int.parse(splittedDate[2]),
                      int.parse(splittedDate[1]),
                      int.parse(splittedDate[0]),
                    );
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
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                                '/');
                        }, child: const Text('Cancelar')),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            FinancialEntity financialEntity = FinancialEntity(
                                null,
                                date,
                                description,
                                value,
                                checkReceivement);

                            await sqliteHelper.create(financialEntity);

                            var result = await sqliteHelper.findAll();
                            log(result.toString());

                            Navigator.of(context).pushReplacementNamed(
                                '/');
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

Future<void> _dialogBuilder(BuildContext context, String fin) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: Column(
          children: [
            Text(fin),
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