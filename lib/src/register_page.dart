//import 'package:financial_flutter/src/data/financial_entity.dart';
import 'dart:developer';
import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Data")),
                    keyboardType: TextInputType.datetime,
                    onSaved: (inputDate) {
                      date = createDateTime(inputDate!)!;
                    },
                    validator: (value) {
                      if(value == null || value.isEmpty || createDateTime(value) == null){
                        return 'Digite uma data válida';
                      }
                      return null;                   
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                  TextFormField(
                    initialValue: description,
                    onSaved: (inputDescription) {
                      description = inputDescription ?? '';
                    },
                    decoration: const InputDecoration(label: Text("Descrição")),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Digite uma descrição';
                      } 
                      return null;
                    },
                  ),
                  TextFormField(
                    onSaved: (inputValue) {
                      value = double.parse(inputValue!);
                    },
                    decoration: const InputDecoration(label: Text("Valor")),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Digite um valor válido';
                      } 
                      return null;
                    },
                    inputFormatters: [
                       FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                    ]
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
      ),
    );
  }
}

DateTime? createDateTime(String inputDate) {
  try {
    DateFormat format = DateFormat("dd/MM/yyyy");
    return format.parseStrict(inputDate);
    // var splittedDate = inputDate.split('/');
    // return DateTime(
    //   int.parse(splittedDate[2]),
    //   int.parse(splittedDate[1]),
    //   int.parse(splittedDate[0]),
    // );
} on Exception{
  return null;
}
}