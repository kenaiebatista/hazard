import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';

const double _kPanelHeight = 361;

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

void _showMovementDetails(BuildContext context, MovementEntity movement) {
  final l10n = AppLocalizations.of(context);
  final isEntry = movement.type == MovementType.entry;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.movementDetailsTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailRow(label: l10n.commonNameLabel, value: movement.product.name),
          _DetailRow(
            label: l10n.movementTypeLabel,
            value: isEntry ? l10n.movementTypeEntry : l10n.movementTypeExit,
          ),
          _DetailRow(
            label: l10n.movementDateLabel,
            value: _formatDate(movement.movementDate),
          ),
          _DetailRow(
            label: l10n.movementQuantityLabel,
            value: '${movement.quantity}',
          ),
          _DetailRow(
            label: l10n.commonDescriptionLabel,
            value: (movement.observation?.isNotEmpty ?? false)
                ? movement.observation!
                : l10n.movementNoDescription,
          ),
          if (movement.returned)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const Icon(Icons.keyboard_return, size: 16),
                  const SizedBox(width: 6),
                  Text(l10n.movementReturnedTag),
                ],
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
      ],
    ),
  );
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

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
                          final isEntry = movement.type == MovementType.entry;
                          final hasDescription =
                              movement.observation?.isNotEmpty ?? false;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              isEntry
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: isEntry ? Colors.green : Colors.red,
                            ),
                            title: Text(movement.product.name),
                            subtitle: Text(
                              '${_formatDate(movement.movementDate)} • '
                              '${l10n.movementQtyInlineLabel}: ${movement.quantity}'
                              '${hasDescription ? ' • ${movement.observation}' : ''}'
                              '${movement.returned ? ' • ${l10n.movementReturnedTag}' : ''}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => _showMovementDetails(context, movement),
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
