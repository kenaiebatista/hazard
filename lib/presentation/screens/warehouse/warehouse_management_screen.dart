import 'package:flutter/material.dart';
import 'package:hazard/core/utils/responsive.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';
import 'package:hazard/presentation/widgets/charts/category_stock_chart.dart';
import 'package:hazard/presentation/widgets/charts/movement_chart.dart';
import 'package:hazard/presentation/widgets/charts/warehouse_chart.dart';
import 'package:hazard/presentation/widgets/dashboard_card_widget.dart';
import 'package:hazard/presentation/widgets/recent_movements_widget.dart';
import 'package:provider/provider.dart';

class WarehouseManagementScreen extends StatelessWidget {
  const WarehouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: WarehouseDashboard(),
      ),
    );
  }
}

class WarehouseDashboard extends StatefulWidget {
  const WarehouseDashboard({super.key});

  @override
  State<WarehouseDashboard> createState() => _WarehouseDashboardState();
}

class _WarehouseDashboardState extends State<WarehouseDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dashboardProvider = context.watch<DashboardProvider>();
    final isMobile = context.isMobile;

    final cards = [
      DashboardCard(
        title: l10n.dashboardTotalStock,
        value: '${dashboardProvider.totalStock}',
        icon: Icons.inventory_2,
      ),
      DashboardCard(
        title: l10n.dashboardEntries7Days,
        value: '${dashboardProvider.entriesLast7Days}',
        icon: Icons.arrow_downward,
      ),
      DashboardCard(
        title: l10n.dashboardExits7Days,
        value: '${dashboardProvider.exitsLast7Days}',
        icon: Icons.arrow_upward,
      ),
      DashboardCard(
        title: l10n.dashboardReturns,
        value: '${dashboardProvider.returnsCount}',
        icon: Icons.keyboard_return,
      ),
    ];

    final statsSection = isMobile
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: cards[1]),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: cards[2]),
                  const SizedBox(width: 16),
                  Expanded(child: cards[3]),
                ],
              ),
            ],
          )
        : Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 16),
              Expanded(child: cards[1]),
              const SizedBox(width: 16),
              Expanded(child: cards[2]),
              const SizedBox(width: 16),
              Expanded(child: cards[3]),
            ],
          );

    final chartsSection = isMobile
        ? Column(
            children: [
              RecentMovementsWidget(),
              const SizedBox(height: 20),
              MovementChart(),
              const SizedBox(height: 20),
              WarehouseStockChart(),
              const SizedBox(height: 20),
              CategoryStockChart(),
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(child: RecentMovementsWidget()),
                  const SizedBox(width: 20),
                  Expanded(child: MovementChart()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: WarehouseStockChart()),
                  const SizedBox(width: 20),
                  Expanded(child: CategoryStockChart()),
                ],
              ),
            ],
          );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          statsSection,
          const SizedBox(height: 25),
          chartsSection,
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
