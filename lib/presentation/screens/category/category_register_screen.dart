import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/entities/subcategory_entity.dart';
import 'package:hazard/presentation/providers/category_provider.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';

class CategoryRegisterDialog extends StatefulWidget {
  final CategoryEntity? category;

  const CategoryRegisterDialog({super.key, this.category});

  @override
  State<CategoryRegisterDialog> createState() => _CategoryRegisterDialogState();
}

class _CategoryRegisterDialogState extends State<CategoryRegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subcategoryController = TextEditingController();
  late final List<SubcategoryEntity> _subcategories;
  bool _isSaving = false;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    _nameController.text = category?.name ?? '';
    _subcategories = List.of(category?.subcategories ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subcategoryController.dispose();
    super.dispose();
  }

  void _addSubcategory() {
    final text = _subcategoryController.text.trim();

    if (text.isEmpty) return;

    final alreadyExists = _subcategories.any((s) => s.name == text);
    if (!alreadyExists) {
      setState(() {
        _subcategories.add(SubcategoryEntity(name: text));
      });
    }

    _subcategoryController.clear();
  }

  void _removeSubcategory(SubcategoryEntity subcategory) {
    setState(() => _subcategories.remove(subcategory));
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final categoryProvider = context.read<CategoryProvider>();

      if (_isEditing) {
        await categoryProvider.updateCategory(
          id: widget.category!.id,
          name: _nameController.text.trim(),
          subcategories: _subcategories,
        );
      } else {
        await categoryProvider.createCategory(
          name: _nameController.text.trim(),
          subcategories: _subcategories,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar categoria: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(-15658620)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isEditing ? 'Editar Categoria' : 'Nova Categoria',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  label: 'Nome',
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  label: 'Subcategoria',
                  controller: _subcategoryController,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addSubcategory,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: _subcategories.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma subcategoria adicionada',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _subcategories.length,
                          itemBuilder: (context, index) {
                            final subcategory = _subcategories[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(-15658620),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text(subcategory.name)),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 18),
                                    onPressed: () =>
                                        _removeSubcategory(subcategory),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 16),
                Material(
                  color: const Color(-15658620),
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: _isSaving ? null : _saveCategory,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: _isSaving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _isEditing ? 'Atualizar' : 'Salvar',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
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
