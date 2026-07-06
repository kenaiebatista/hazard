import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';
import 'package:hazard/presentation/widgets/rightside_warehouse_screen_widget.dart';

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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir armazéns'),
        content: Text(
          'Deseja excluir ${provider.selectedIds.length} armazém(ns) selecionado(s)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteSelectedWarehouses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<WarehouseProvider>();

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(-15658620)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Text(
                                'Lista de ${l10n.warehouseTitle}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              if (provider.isSelecting)
                                IconButton(
                                  onPressed: provider.stopSelecting,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              IconButton(
                                onPressed: () => _handleDeleteTap(provider),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color:
                                      provider.isSelecting &&
                                          provider.selectedIds.isEmpty
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(width: 2, color: Color(-15658620)),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            _editingWarehouse != null
                                ? 'Editar Armazém'
                                : 'Novo Armazém',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Color(-15658620), thickness: 1),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Builder(
                          builder: (context) {
                            if (provider.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (provider.error != null) {
                              return Center(child: Text(provider.error!));
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
                                            value: provider.isSelected(
                                              warehouse.id,
                                            ),
                                            onChanged: (_) => provider
                                                .toggleSelection(warehouse.id),
                                          )
                                        : const Icon(Icons.warehouse),
                                    title: Text(warehouse.name),
                                    subtitle: Text(warehouse.address),
                                    trailing: provider.isSelecting
                                        ? Text(
                                            l10n.warehouseCapacity(
                                              warehouse.capacity,
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                l10n.warehouseCapacity(
                                                  warehouse.capacity,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_outlined,
                                                ),
                                                onPressed: () => setState(
                                                  () => _editingWarehouse =
                                                      warehouse,
                                                ),
                                              ),
                                            ],
                                          ),
                                    onTap: provider.isSelecting
                                        ? () => provider.toggleSelection(
                                            warehouse.id,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Container(width: 2, color: Color(-15658620)),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        child: WarehouseRightsideWidget(
                          key: ValueKey(_editingWarehouse?.id ?? 'new'),
                          warehouse: _editingWarehouse,
                          onDone: () =>
                              setState(() => _editingWarehouse = null),
                        ),
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
