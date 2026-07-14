import 'package:flutter/material.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/models/recent_movement_chart_data.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const Color _entryColor = Color(0xFF22C55E);
const Color _exitColor = Color(0xFFEF4444);

class RecentMovementsChart extends StatelessWidget {
  const RecentMovementsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chartData = context
        .watch<DashboardProvider>()
        .recentMovementsChartData();

    final legend = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendDot(color: _entryColor, label: l10n.chartMovementEntriesLegend),
        const SizedBox(width: 16),
        _LegendDot(color: _exitColor, label: l10n.chartMovementExitsLegend),
      ],
    );

    return Card(
      elevation: 3,
      child: SizedBox(
        height: 361,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: chartData.isEmpty
              ? Center(child: Text(l10n.movementEmptyList))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: l10n.dashboardRecentMovementsTitle,
                        ),
                        primaryXAxis: const CategoryAxis(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries>[
                          ColumnSeries<RecentMovementChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (d, _) => d.label,
                            yValueMapper: (d, _) => d.signedQuantity,
                            pointColorMapper: (d, _) =>
                                d.isEntry ? _entryColor : _exitColor,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    legend,
                  ],
                ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
