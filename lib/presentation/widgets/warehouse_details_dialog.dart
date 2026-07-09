import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/widgets/movement_details_dialog.dart';
import 'package:hazard/presentation/widgets/movement_leading_indicator.dart';
import 'package:hazard/presentation/widgets/product_thumbnail.dart';

void showWarehouseDetailsDialog(BuildContext context, WarehouseEntity warehouse) {
  showDialog(
    context: context,
    builder: (dialogContext) => WarehouseDetailsDialog(warehouse: warehouse),
  );
}

class WarehouseDetailsDialog extends StatelessWidget {
  final WarehouseEntity warehouse;

  const WarehouseDetailsDialog({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dashboardProvider = context.watch<DashboardProvider>();
    final products = dashboardProvider.productsForWarehouse(warehouse.id);
    final movements = dashboardProvider.movementsForWarehouse(
      warehouse.id,
      limit: 6,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 620),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        warehouse.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Text(
                  warehouse.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Divider(color: Theme.of(context).primaryColor),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.warehouseProductsSectionTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (products.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(l10n.warehouseNoProductsRegistered),
                          )
                        else
                          for (final product in products)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ProductThumbnail(
                                imageUrl: product.imageUrl,
                              ),
                              title: Text(product.name),
                              trailing: Text(
                                l10n.stockAmount(product.amount),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.warehouseRecentMovementsTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (movements.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(l10n.warehouseNoMovementsRegistered),
                          )
                        else
                          for (final movement in movements)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: MovementLeadingIndicator(
                                movement: movement,
                              ),
                              title: Text(movement.product.name),
                              subtitle: Text(
                                '${formatMovementDate(movement.movementDate)} • '
                                '${l10n.movementQtyInlineLabel}: ${movement.quantity}',
                              ),
                              onTap: () =>
                                  showMovementDetailsDialog(context, movement),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
