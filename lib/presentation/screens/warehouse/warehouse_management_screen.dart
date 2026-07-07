import 'package:flutter/material.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';
import 'package:hazard/presentation/widgets/charts/movement_chart.dart';
import 'package:hazard/presentation/widgets/dashboard_card_widget.dart';

class WarehouseManagementScreen extends StatelessWidget {
  const WarehouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppbarWidget(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: WarehouseDashboard(),
      ),
      //child: Text(l10n.warehouseManageTitle, style: const TextStyle(fontSize: 24)),
    );
  }
}

class WarehouseDashboard extends StatelessWidget {
  const WarehouseDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: DashboardCard(
                  title: 'Estoque Geral',
                  value: '0',
                  icon: Icons.inventory_2,
                ),
              ),
              SizedBox(
                width: 16,
                child: Expanded(
                  child: DashboardCard(
                    title: 'Entrada (7 dias)',
                    value: '0',
                    icon: Icons.arrow_downward,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
                child: Expanded(
                  child: DashboardCard(
                    title: 'Saída (7 dias)',
                    value: '0',
                    icon: Icons.arrow_upward,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
                child: Expanded(
                  child: DashboardCard(
                    title: 'Devoluções',
                    value: '0',
                    icon: Icons.keyboard_return,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),

          Row(
            children: [
              //Expanded(
              //  child: MovementChart(),
              //),
              SizedBox(width: 20),

              Expanded(child: Placeholder(fallbackHeight: 320)),
            ],
          ),

          Row(
            children: [
              Expanded(child: Placeholder(fallbackHeight: 320)),

              SizedBox(width: 20),

              Expanded(child: Placeholder(fallbackHeight: 320)),
            ],
          ),
          SizedBox(height: 20),
          Placeholder(fallbackHeight: 250),
        ],
      ),
    );
  }
}
