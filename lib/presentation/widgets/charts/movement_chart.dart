import 'package:flutter/material.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/models/movement_chart_data.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MovementChart extends StatelessWidget {
  const MovementChart({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final weekdayLabels = [
      l10n.weekdayMon,
      l10n.weekdayTue,
      l10n.weekdayWed,
      l10n.weekdayThu,
      l10n.weekdayFri,
      l10n.weekdaySat,
      l10n.weekdaySun,
    ];
    final chartData = context.watch<DashboardProvider>().weeklyChartData(
      weekdayLabels,
    );

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SfCartesianChart(
          title: ChartTitle(text: l10n.chartMovementTitle),
          legend: const Legend(
            isVisible: true,
            position: LegendPosition.bottom,
          ),
          primaryXAxis: const CategoryAxis(),
          series: <CartesianSeries>[
            LineSeries<MovementChartData, String>(
              name: l10n.chartMovementEntriesLegend,
              dataSource: chartData,
              xValueMapper: (d, _) => d.day,
              yValueMapper: (d, _) => d.entries,
            ),
            LineSeries<MovementChartData, String>(
              name: l10n.chartMovementExitsLegend,
              dataSource: chartData,
              xValueMapper: (d, _) => d.day,
              yValueMapper: (d, _) => d.exits,
            ),
          ],
        ),
      ),
    );
  }
}
