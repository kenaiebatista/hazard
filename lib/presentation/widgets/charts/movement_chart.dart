//import 'package:flutter/material.dart';
//
//class MovementChart extends StatelessWidget {
//  const MovementChart({super.key});
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      elevation: 2,
//      child: Padding(
//        padding: EdgeInsets.all(20),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            Text(
//              'Entradas x Saídas (7 dias)',
//              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//            ),
//            const SizedBox(height: 20),
//
//            SizedBox(
//              height: 250,
//              child: BarChart(
//                BarChartData(
//                  alignment: BarChartAlignment.spaceAround,
//                  borderData: FlBorderData(show: false),
//                  gridData: const FlGridData(show: true),
//                  titlesData: FlTitlesData(
//                    topTitles: const AxisTitles(
//                      sideTitles: SideTitles(showTitles: false),
//                    ),
//                    rightTitles: const AxisTitles(
//                      sideTitles: SideTitles(showTitles: false),
//                    ),
//                    bottomTitles: AxisTitles(
//                      sideTitles: SideTitles(
//                        showTitles: true,
//                        getTitlesWidget: (value, meta) {
//                          const dias = [
//                            'Seg',
//                            'Ter',
//                            'Qua',
//                            'Qui',
//                            'Sex',
//                            'Sab',
//                            'Dom',
//                          ];
//                          return Text(dias[value.toInt()]);
//                        },
//                      ),
//                    ),
//                  ),
//                  barGroups: [_group(0, 18, 12), _group(1, 25, 17)],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//  BarChartGroupData _group(int x, double entradas, double saidas) {
//
//    return BarChartGroupData(
//      x: x,
//
//      barsSpace: 4,
//
//      barRods: [
//
//        BarChartRodData(
//          toY: entradas,
//          width: 10,
//          color: Colors.green,
//        ),
//
//        BarChartRodData(
//          toY: saidas,
//          width: 10,
//          color: Colors.red,
//        ),
//      ],
//    );
//  }
//}
//