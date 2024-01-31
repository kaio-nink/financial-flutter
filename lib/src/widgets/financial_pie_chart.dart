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
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          );
        }
        var financials = snapshot.data as List<FinancialEntity>;
        double receivement = 0;
        double payment = 0;

        for (var fin in financials) {
          fin.receivement ? receivement++ : payment++;
        }

        return Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: PieChart(
                  PieChartData(
                      centerSpaceRadius: 5,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      sections: [
                        PieChartSectionData(
                          value: receivement,
                          color: Colors.green,
                          radius: 100,
                          title: '$receivement',
                          titleStyle: const TextStyle(color: Colors.white)
                        ),
                        PieChartSectionData(
                          value: payment,
                          color: Colors.red,
                          radius: 100,
                          title: '$payment',
                          titleStyle: const TextStyle(color: Colors.white)
                        )
                      ]),
                  swapAnimationDuration:
                      const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    const Text('Pagamento', style: TextStyle(fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(width: 20,),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                    const Text('Recebimento', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
