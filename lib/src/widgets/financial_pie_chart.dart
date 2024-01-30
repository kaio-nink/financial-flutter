import 'dart:developer';

import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:financial_flutter/src/data/sqlite_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinancialPieChart extends StatelessWidget {
  const FinancialPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SqliteHelper().findAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        var financials = snapshot.data as List<FinancialEntity>;
        double receivement = 0;
        double payment = 0;
        
        for (var fin in financials) { 
          fin.receivement ? receivement++ : payment ++;
        }

        return PieChart(
          PieChartData(
              centerSpaceRadius: 5,
              borderData: FlBorderData(show: true),
              sectionsSpace: 2,
              sections: [
                PieChartSectionData(
                  value: receivement,
                  color: Colors.green,
                  radius: 100,
                  title: 'Recebimentos', 
                ),
                PieChartSectionData(
                  value: payment,
                  color: Colors.red,
                  radius: 100,
                  title: 'Pagamentos',
                )
              ]),
          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        );
      },
    );
  }
}
