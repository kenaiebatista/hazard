import 'package:flutter/material.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/widgets/charts/chart_colors.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _CategorySlice {
  final String category;
  final int quantity;
  final double percentage;
  final Color color;

  const _CategorySlice({
    required this.category,
    required this.quantity,
    required this.percentage,
    required this.color,
  });
}

class CategoryStockChart extends StatelessWidget {
  const CategoryStockChart({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chartData = context.watch<DashboardProvider>().categoryChartData(
      l10n.dashboardNoCategory,
    );

    final total = chartData.fold<int>(0, (sum, d) => sum + d.quantity);

    final slices = <_CategorySlice>[
      for (var i = 0; i < chartData.length; i++)
        _CategorySlice(
          category: chartData[i].category,
          quantity: chartData[i].quantity,
          percentage: total == 0 ? 0 : chartData[i].quantity / total * 100,
          color: chartColors[i % chartColors.length],
        ),
    ];

    return Card(
      elevation: 3,
      child: Container(
        height: 361,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: slices.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(l10n.chartNoProductsRegistered),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SfCircularChart(
                        title: ChartTitle(text: l10n.chartCategoryTitle),
                        series: <CircularSeries>[
                          PieSeries<_CategorySlice, String>(
                            dataSource: slices,
                            xValueMapper: (d, _) => d.category,
                            yValueMapper: (d, _) => d.quantity,
                            pointColorMapper: (d, _) => d.color,
                            dataLabelMapper: (d, _) =>
                                '${d.percentage.toStringAsFixed(0)}%',
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final slice in slices)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: slice.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${slice.category} (${slice.quantity})',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
