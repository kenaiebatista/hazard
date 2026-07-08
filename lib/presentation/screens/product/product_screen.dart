import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/core/errors/app_exception.dart';
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

    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.productDeleteTitle),
        content: Text(l10n.productDeleteContent(provider.selectedIds.length)),
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8, right: 10),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        l10n.commonListOf(l10n.productTitle),
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
                              : Theme.of(context).primaryColor,
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
              Divider(color: Theme.of(context).primaryColor, thickness: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Builder(
                    builder: (context) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (provider.error != null) {
                        return Center(
                          child: Text(describeError(provider.error!, l10n)),
                        );
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
                                  l10n.productSubtitle(
                                    product.sku,
                                    product.description,
                                  ),
                                ),
                                trailing: Text(
                                  l10n.productQuantityShort(product.amount),
                                ),
                                onTap: () =>
                                    provider.toggleSelection(product.id),
                              ),
                            );
                          }

                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              leading: _ProductThumbnail(
                                imageUrl: product.imageUrl,
                              ),
                              title: Text(product.name),
                              subtitle: Text(
                                l10n.productSubtitle(
                                  product.sku,
                                  product.description,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.stockAmount(product.amount),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => ProductRegisterDialog(
                                        product: product,
                                      ),
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

class _ProductThumbnail extends StatelessWidget {
  final String? imageUrl;

  const _ProductThumbnail({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Icon(Icons.inventory_2_outlined);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        imageUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.inventory_2_outlined),
      ),
    );
  }
}
