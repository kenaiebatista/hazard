import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/screens/product/product_register_screen.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  Future<void> _handleDeleteTap(ProductProvider provider) async {
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
        title: const Text('Excluir produtos'),
        content: Text(
          'Deseja excluir ${provider.selectedIds.length} produto(s) selecionado(s)?',
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
      await provider.deleteSelectedProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<ProductProvider>();

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
                padding: const EdgeInsets.only(left: 10.0, top: 8, right: 10),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        'Lista de ${l10n.productTitle}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (provider.isSelecting) {
                            provider.stopSelecting();
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => const ProductRegisterDialog(),
                            );
                          }
                        },
                        icon: Icon(
                          provider.isSelecting ? Icons.close : Icons.add,
                          color: provider.isSelecting
                              ? Colors.grey
                              : const Color(-15658620),
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
              const Divider(color: Color(-15658620), thickness: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Builder(
                    builder: (context) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (provider.error != null) {
                        return Center(child: Text(provider.error!));
                      }
                      if (provider.products.isEmpty) {
                        return Center(child: Text(l10n.productEmpty));
                      }
                      return ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final product = provider.products[index];

                          if (provider.isSelecting) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                leading: Checkbox(
                                  value: provider.isSelected(product.id),
                                  onChanged: (_) =>
                                      provider.toggleSelection(product.id),
                                ),
                                title: Text(product.name),
                                subtitle: Text(
                                  'SKU: ${product.sku} • ${product.description}',
                                ),
                                trailing: Text('Qtd: ${product.amount}'),
                                onTap: () =>
                                    provider.toggleSelection(product.id),
                              ),
                            );
                          }

                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              leading: const Icon(Icons.inventory_2_outlined),
                              title: Text(product.name),
                              subtitle: Text(
                                'SKU: ${product.sku} • ${product.description}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Qtd: ${product.amount}'),
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ProductRegisterDialog(product: product),
                                    ),
                                  ),
                                ],
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
