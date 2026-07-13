import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/presentation/errors/error_translator.dart';
import 'package:hazard/core/utils/responsive.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';
import 'package:hazard/presentation/widgets/icon_square_widget.dart';
import 'package:hazard/presentation/widgets/info_badge_widget.dart';
import 'package:hazard/presentation/widgets/rightside_warehouse_screen_widget.dart';
import 'package:hazard/presentation/widgets/warehouse_details_dialog.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  WarehouseEntity? _editingWarehouse;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WarehouseProvider>().loadWarehouses();
      context.read<DashboardProvider>().loadDashboardData();
    });
  }

  Future<void> _handleDeleteTap(WarehouseProvider provider) async {
    if (!provider.isSelecting) {
      provider.startSelecting();
      return;
    }
    if (provider.selectedIds.isEmpty) {
      provider.stopSelecting();
      return;
    }

    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.warehouseDeleteTitle),
        content: Text(l10n.warehouseDeleteContent(provider.selectedIds.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.commonDelete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteSelectedWarehouses();
    }
  }

  void _openWarehouseFormDialog({WarehouseEntity? warehouse}) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450, maxHeight: 640),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          warehouse != null
                              ? l10n.warehouseEditTitle
                              : l10n.warehouseNewTitle,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: WarehouseRightsideWidget(
                    key: ValueKey(warehouse?.id ?? 'new'),
                    warehouse: warehouse,
                    onDone: () => Navigator.of(dialogContext).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    WarehouseProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 8, right: 10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              l10n.commonListOf(l10n.warehouseTitle),
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            if (provider.isSelecting)
              IconButton(
                onPressed: provider.stopSelecting,
                icon: const Icon(Icons.close, color: Colors.grey),
              ),
            IconButton(
              onPressed: () => _handleDeleteTap(provider),
              icon: Icon(
                Icons.delete_outline,
                color: provider.isSelecting && provider.selectedIds.isEmpty
                    ? Colors.grey
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseList(
    BuildContext context,
    AppLocalizations l10n,
    WarehouseProvider provider, {
    required bool isDesktop,
  }) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return Center(child: Text(describeError(provider.error!, l10n)));
    }
    if (provider.warehouses.isEmpty) {
      return Center(child: Text(l10n.warehouseEmpty));
    }
    return ListView.builder(
      itemCount: provider.warehouses.length,
      itemBuilder: (context, index) {
        final warehouse = provider.warehouses[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: provider.isSelecting
                ? Checkbox(
                    value: provider.isSelected(warehouse.id),
                    onChanged: (_) => provider.toggleSelection(warehouse.id),
                  )
                : const IconSquareWidget(icon: Icons.warehouse),
            title: Text(warehouse.name),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    warehouse.address,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                InfoBadgeWidget(
                  label: l10n.warehouseCapacity(warehouse.capacity),
                ),
              ],
            ),
            trailing: provider.isSelecting
                ? null
                : IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      if (isDesktop) {
                        setState(() => _editingWarehouse = warehouse);
                      } else {
                        _openWarehouseFormDialog(warehouse: warehouse);
                      }
                    },
                  ),
            onTap: provider.isSelecting
                ? () => provider.toggleSelection(warehouse.id)
                : () => showWarehouseDetailsDialog(context, warehouse),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<WarehouseProvider>();
    final isDesktop = context.isDesktop;

    return Scaffold(
      appBar: AppbarWidget(),
      floatingActionButton: isDesktop
          ? null
          : FloatingActionButton(
              onPressed: () => _openWarehouseFormDialog(),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
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
              isDesktop
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildHeader(context, l10n, provider),
                            ),
                          ],
                        ),
                      ),
                    )
                  : _buildHeader(context, l10n, provider),
              Divider(color: Theme.of(context).primaryColor, thickness: 1),
              Expanded(
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: _buildWarehouseList(
                                context,
                                l10n,
                                provider,
                                isDesktop: true,
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 8,
                                  ),
                                  child: Text(
                                    _editingWarehouse != null
                                        ? l10n.warehouseEditTitle
                                        : l10n.warehouseNewTitle,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Theme.of(context).cardColor,
                                    child: WarehouseRightsideWidget(
                                      key: ValueKey(
                                        _editingWarehouse?.id ?? 'new',
                                      ),
                                      warehouse: _editingWarehouse,
                                      onDone: () => setState(
                                        () => _editingWarehouse = null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: _buildWarehouseList(
                          context,
                          l10n,
                          provider,
                          isDesktop: false,
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
