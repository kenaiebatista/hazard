import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/widgets/product_thumbnail.dart';

String formatMovementDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

void showMovementDetailsDialog(BuildContext context, MovementEntity movement) {
  final l10n = AppLocalizations.of(context);
  final isEntry = movement.type == MovementType.entry;

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.movementDetailsTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProductThumbnail(imageUrl: movement.product.imageUrl),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    movement.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  isEntry ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isEntry ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DetailRow(
              label: l10n.movementTypeLabel,
              value: isEntry ? l10n.movementTypeEntry : l10n.movementTypeExit,
            ),
            _DetailRow(
              label: l10n.movementDateLabel,
              value: formatMovementDate(movement.movementDate),
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
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
