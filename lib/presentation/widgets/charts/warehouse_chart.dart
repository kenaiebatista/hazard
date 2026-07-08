import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/widgets/charts/chart_colors.dart';

class WarehouseStockChart extends StatelessWidget {
  const WarehouseStockChart({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data =
        context.watch<DashboardProvider>().warehouseChartData;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SfCartesianChart(

          title: ChartTitle(
            text: l10n.chartWarehouseTitle,
          ),

          primaryXAxis: const CategoryAxis(),

          series: <CartesianSeries>[

            ColumnSeries(
              dataSource: data,

              xValueMapper: (d, _) => d.warehouse,

              yValueMapper: (d, _) => d.quantity,

              pointColorMapper: (d, index) =>
                  chartColors[index % chartColors.length],

              width: 0.2,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),

          ],
        ),
      ),
    );
  }
}