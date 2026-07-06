import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/category_provider.dart';
import 'package:hazard/presentation/screens/category/category_register_screen.dart';
import 'package:hazard/presentation/widgets/app_appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().loadCategories();
    });
  }

  Future<void> _handleDeleteTap(CategoryProvider provider) async {
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
        title: const Text('Excluir categorias'),
        content: Text(
          'Deseja excluir ${provider.selectedIds.length} categoria(s) selecionada(s)?',
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
      await provider.deleteSelectedCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<CategoryProvider>();

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
                        'Lista de ${l10n.categoryTitle}',
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
                              builder: (_) => const CategoryRegisterDialog(),
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
                      if (provider.categories.isEmpty) {
                        return Center(child: Text(l10n.categoryEmpty));
                      }
                      return ListView.builder(
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          final category = provider.categories[index];

                          if (provider.isSelecting) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                leading: Checkbox(
                                  value: provider.isSelected(category.id),
                                  onChanged: (_) =>
                                      provider.toggleSelection(category.id),
                                ),
                                title: Text(category.name),
                                subtitle: Text(
                                  '${category.subcategories.length} subcategorias',
                                ),
                                onTap: () =>
                                    provider.toggleSelection(category.id),
                              ),
                            );
                          }

                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: ExpansionTile(
                              leading: const Icon(Icons.category_outlined),
                              title: Row(
                                children: [
                                  Expanded(child: Text(category.name)),
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => CategoryRegisterDialog(
                                        category: category,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                '${category.subcategories.length} subcategorias',
                              ),
                              children: category.subcategories.isEmpty
                                  ? const [
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          'Nenhuma subcategoria cadastrada',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ]
                                  : category.subcategories
                                        .map(
                                          (subcategory) => ListTile(
                                            dense: true,
                                            leading: const Icon(
                                              Icons.subdirectory_arrow_right,
                                              size: 18,
                                            ),
                                            title: Text(subcategory.name),
                                          ),
                                        )
                                        .toList(),
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
