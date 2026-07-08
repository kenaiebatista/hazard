import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/core/errors/app_exception.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';
import 'package:hazard/presentation/widgets/movement_dialog.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
      context.read<WarehouseProvider>().loadWarehouses();
    });
  }

  WarehouseEntity? _findWarehouse(
    List<WarehouseEntity> warehouses,
    String warehouseId,
  ) {
    try {
      return warehouses.firstWhere((warehouse) => warehouse.id == warehouseId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _openMovementDialog() async {
    await showDialog(context: context, builder: (_) => const MovementDialog());
    if (mounted) context.read<ProductProvider>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final productProvider = context.watch<ProductProvider>();
    final warehouses = context.watch<WarehouseProvider>().warehouses;

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8, right: 10),
                child: Row(
                  children: [
                    Text(
                      l10n.commonListOf(l10n.stockTitle),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _openMovementDialog,
                      icon: Icon(
                        Icons.swap_horiz,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Theme.of(context).primaryColor, thickness: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Builder(
                    builder: (context) {
                      if (productProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (productProvider.error != null) {
                        return Center(
                          child: Text(
                            describeError(productProvider.error!, l10n),
                          ),
                        );
                      }
                      if (productProvider.products.isEmpty) {
                        return Center(child: Text(l10n.stockEmpty));
                      }
                      return ListView.builder(
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          final warehouse = _findWarehouse(
                            warehouses,
                            product.warehouseId,
                          );

                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              leading: const Icon(Icons.inventory_2_outlined),
                              title: Text(product.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(product.description),
                                  Text(
                                    '${l10n.stockSku(product.sku)} • '
                                    '${l10n.stockWarehouse(warehouse?.name ?? l10n.stockWarehouseUnknown)}',
                                  ),
                                ],
                              ),
                              trailing: Text(
                                l10n.stockAmount(product.amount ?? 0),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
