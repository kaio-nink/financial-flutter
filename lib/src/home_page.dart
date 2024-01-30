import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:financial_flutter/src/financial_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const FinancialTable(),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
              child: const Text('Cadastrar registro'))
        ],
      ),
    );
  }
}
