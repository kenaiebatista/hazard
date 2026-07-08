import 'package:flutter/material.dart';
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

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardCard(
                  title: l10n.dashboardTotalStock,
                  value: '${dashboardProvider.totalStock}',
                  icon: Icons.inventory_2,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: l10n.dashboardEntries7Days,
                  value: '${dashboardProvider.entriesLast7Days}',
                  icon: Icons.arrow_downward,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: l10n.dashboardExits7Days,
                  value: '${dashboardProvider.exitsLast7Days}',
                  icon: Icons.arrow_upward,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: l10n.dashboardReturns,
                  value: '${dashboardProvider.returnsCount}',
                  icon: Icons.keyboard_return,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              Expanded(child: RecentMovementsWidget(),),
              SizedBox(width: 20),

              Expanded(child: MovementChart()),
            ],
          ),

          Row(
            children: [
              Expanded(child: WarehouseStockChart()),

              SizedBox(width: 20),
              Expanded(child: CategoryStockChart()),
            ],
          ),
          SizedBox(height: 20),
          
        ],
      ),
    );
  }
}
