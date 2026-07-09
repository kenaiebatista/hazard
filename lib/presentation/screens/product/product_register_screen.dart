import 'package:flutter/material.dart';
import 'package:hazard/presentation/errors/error_translator.dart';
import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/entities/subcategory_entity.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/category_provider.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_dropdown_field_widget.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';
import 'package:provider/provider.dart';

class ProductRegisterDialog extends StatefulWidget {
  final ProductEntity? product;

  const ProductRegisterDialog({super.key, this.product});

  @override
  State<ProductRegisterDialog> createState() => _ProductRegisterDialogState();
}

class _ProductRegisterDialogState extends State<ProductRegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skuController = TextEditingController();
  final _imageUrlController = TextEditingController();

  CategoryEntity? _selectedCategory;
  SubcategoryEntity? _selectedSubcategory;
  WarehouseEntity? _selectedWarehouse;
  bool _isSaving = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    if (product != null) {
      _nameController.text = product.name;
      _descriptionController.text = product.description;
      _skuController.text = product.sku;
      _imageUrlController.text = product.imageUrl ?? '';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CategoryProvider>().loadCategories();
      if (!mounted) return;
      await context.read<WarehouseProvider>().loadWarehouses();
      if (!mounted || product == null) return;

      final categories = context.read<CategoryProvider>().categories;
      final warehouses = context.read<WarehouseProvider>().warehouses;

      CategoryEntity? category;
      try {
        category = categories.firstWhere((c) => c.id == product.categoryId);
      } catch (_) {}

      SubcategoryEntity? subcategory;
      if (category != null) {
        try {
          subcategory = category.subcategories.firstWhere(
            (s) => s.id == product.subcategoryId,
          );
        } catch (_) {}
      }

      WarehouseEntity? warehouse;
      try {
        warehouse = warehouses.firstWhere((w) => w.id == product.warehouseId);
      } catch (_) {}

      setState(() {
        _selectedCategory = category;
        _selectedSubcategory = subcategory;
        _selectedWarehouse = warehouse;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final productProvider = context.read<ProductProvider>();

      final imageUrl = _imageUrlController.text.trim();

      if (_isEditing) {
        await productProvider.updateProduct(
          id: widget.product!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          sku: _skuController.text.trim(),
          categoryId: _selectedCategory!.id,
          subcategoryId: _selectedSubcategory!.id,
          warehouseId: _selectedWarehouse!.id,
          amount: widget.product!.amount,
          imageUrl: imageUrl.isEmpty ? null : imageUrl,
        );
      } else {
        await productProvider.createProduct(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          sku: _skuController.text.trim(),
          categoryId: _selectedCategory!.id,
          subcategoryId: _selectedSubcategory!.id,
          warehouseId: _selectedWarehouse!.id,
          imageUrl: imageUrl.isEmpty ? null : imageUrl,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.productSaveErrorPrefix(describeError(e, l10n))),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = context.watch<CategoryProvider>().categories;
    final warehouses = context.watch<WarehouseProvider>().warehouses;
    final subcategories = _selectedCategory?.subcategories ?? [];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 450,
        constraints: const BoxConstraints(maxHeight: 640),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isEditing
                            ? l10n.productRegisterEditTitle
                            : l10n.productRegisterNewTitle,
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  TextFieldWidget(
                    label: l10n.commonNameLabel,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    isMandatory: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.commonValidatorNameRequired;
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: l10n.commonDescriptionLabel,
                    controller: _descriptionController,
                    isMandatory: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.commonValidatorDescriptionRequired;
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: l10n.productSkuLabel,
                    controller: _skuController,
                    isMandatory: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.productValidatorSkuRequired;
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: l10n.productImageUrlLabel,
                    controller: _imageUrlController,
                    isMandatory: false,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      final trimmed = value?.trim() ?? '';
                      if (trimmed.isEmpty) return null;
                      final uri = Uri.tryParse(trimmed);
                      if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                        return l10n.productValidatorImageUrlInvalid;
                      }
                      return null;
                    },
                  ),
                  DropdownFieldWidget<CategoryEntity>(
                    label: l10n.productCategoryLabel,
                    value: _selectedCategory,
                    isMandatory: true,
                    items: categories.map((category) {
                      return DropdownMenuItem<CategoryEntity>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (category) {
                      setState(() {
                        _selectedCategory = category;
                        _selectedSubcategory = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return l10n.productValidatorCategoryRequired;
                      }
                      return null;
                    },
                  ),
                  DropdownFieldWidget<SubcategoryEntity>(
                    label: l10n.commonSubcategoryLabel,
                    value: _selectedSubcategory,
                    isMandatory: true,
                    items: subcategories.map((subcategory) {
                      return DropdownMenuItem<SubcategoryEntity>(
                        value: subcategory,
                        child: Text(subcategory.name),
                      );
                    }).toList(),
                    onChanged: (subcategory) {
                      setState(() {
                        _selectedSubcategory = subcategory;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return l10n.productValidatorSubcategoryRequired;
                      }
                      return null;
                    },
                  ),
                  DropdownFieldWidget<WarehouseEntity>(
                    label: l10n.warehouseTitle,
                    value: _selectedWarehouse,
                    isMandatory: true,
                    items: warehouses.map((warehouse) {
                      return DropdownMenuItem<WarehouseEntity>(
                        value: warehouse,
                        child: Text(warehouse.name),
                      );
                    }).toList(),
                    onChanged: (warehouse) {
                      setState(() {
                        _selectedWarehouse = warehouse;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return l10n.productValidatorWarehouseRequired;
                      }
                      return null;
                    },
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: _isSaving ? null : _saveProduct,
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
                                  _isEditing
                                      ? l10n.commonUpdate
                                      : l10n.commonSave,
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
      ),
    );
  }
}
