import 'package:financial_flutter/src/widgets/financial_pie_chart.dart';
import 'package:financial_flutter/src/widgets/financial_table.dart';
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
      body: Center(
        child: OverflowBox(
          child: Column(
            children: [
              const FinancialTable(),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
                child: FinancialPieChart(),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: const Text('Cadastrar registro'))
            ],
          ),
        ),
      ),
    );
  }
}
