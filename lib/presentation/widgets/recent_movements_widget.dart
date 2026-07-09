import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/widgets/movement_details_dialog.dart';
import 'package:hazard/presentation/widgets/movement_leading_indicator.dart';

const double _kPanelHeight = 361;

class RecentMovementsWidget extends StatelessWidget {
  const RecentMovementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final movements = context.watch<DashboardProvider>().recentMovements();

    return Card(
      elevation: 3,
      child: SizedBox(
        height: _kPanelHeight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.dashboardRecentMovementsTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: movements.isEmpty
                    ? Center(child: Text(l10n.movementEmptyList))
                    : ListView.builder(
                        itemCount: movements.length,
                        itemBuilder: (context, index) {
                          final movement = movements[index];
                          final hasDescription =
                              movement.observation?.isNotEmpty ?? false;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: MovementLeadingIndicator(
                              movement: movement,
                            ),
                            title: Text(movement.product.name),
                            subtitle: Text(
                              '${formatMovementDate(movement.movementDate)} • '
                              '${l10n.movementQtyInlineLabel}: ${movement.quantity}'
                              '${hasDescription ? ' • ${movement.observation}' : ''}'
                              '${movement.returned ? ' • ${l10n.movementReturnedTag}' : ''}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () =>
                                showMovementDetailsDialog(context, movement),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
