import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/presentation/errors/error_translator.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/movement_provider.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_dropdown_field_widget.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';
import 'package:hazard/presentation/widgets/movement_details_dialog.dart';
import 'package:hazard/presentation/widgets/movement_leading_indicator.dart';
import 'package:hazard/presentation/widgets/movement_menu_button.dart';

enum _MovementView { menu, add, editList, editForm, removeList, returnList }

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

class MovementDialog extends StatefulWidget {
  const MovementDialog({super.key});

  @override
  State<MovementDialog> createState() => _MovementDialogState();
}

class _MovementDialogState extends State<MovementDialog> {
  _MovementView _view = _MovementView.menu;
  MovementEntity? _editingMovement;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
      context.read<MovementProvider>().loadMovements();
      context.read<WarehouseProvider>().loadWarehouses();
    });
  }

  void _goTo(_MovementView view, {MovementEntity? movement}) {
    setState(() {
      _view = view;
      _editingMovement = movement;
    });
  }

  String _title(AppLocalizations l10n) {
    switch (_view) {
      case _MovementView.menu:
        return l10n.movementDialogTitle;
      case _MovementView.add:
        return l10n.movementAddTitle;
      case _MovementView.editList:
        return l10n.movementEditTitle;
      case _MovementView.editForm:
        return l10n.movementEditTitle;
      case _MovementView.removeList:
        return l10n.movementRemoveTitle;
      case _MovementView.returnList:
        return l10n.movementReturnTitle;
    }
  }

  bool get _canGoBack => _view != _MovementView.menu;

  void _handleBack() {
    if (_view == _MovementView.editForm) {
      _goTo(_MovementView.editList);
    } else {
      _goTo(_MovementView.menu);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 480,
        constraints: const BoxConstraints(maxHeight: 640),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (_canGoBack)
                    IconButton(
                      onPressed: _handleBack,
                      icon: const Icon(Icons.arrow_back),
                    ),
                  Expanded(
                    child: Text(
                      _title(l10n),
                      style: const TextStyle(fontSize: 20),
                      textAlign: _canGoBack ? TextAlign.center : TextAlign.left,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Divider(color: Theme.of(context).primaryColor),
              Flexible(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_view) {
      case _MovementView.menu:
        return _MovementMenu(
          onAdd: () => _goTo(_MovementView.add),
          onEdit: () => _goTo(_MovementView.editList),
          onRemove: () => _goTo(_MovementView.removeList),
          onReturn: () => _goTo(_MovementView.returnList),
        );
      case _MovementView.add:
        return const _MovementForm();
      case _MovementView.editForm:
        return _MovementForm(movement: _editingMovement);
      case _MovementView.editList:
        return _MovementList(
          onTapMovement: (movement) =>
              _goTo(_MovementView.editForm, movement: movement),
        );
      case _MovementView.removeList:
        return const _MovementList(removeMode: true);
      case _MovementView.returnList:
        return const _MovementList(returnMode: true);
    }
  }
}

class _MovementMenu extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  final VoidCallback onReturn;

  const _MovementMenu({
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuButton(
            icon: Icons.add,
            label: l10n.movementActionAdd,
            onTap: onAdd,
          ),
          MenuButton(
            icon: Icons.edit,
            label: l10n.movementActionEdit,
            onTap: onEdit,
          ),
          MenuButton(
            icon: Icons.delete_outline,
            label: l10n.movementActionRemove,
            onTap: onRemove,
          ),
          MenuButton(
            icon: Icons.keyboard_return,
            label: l10n.movementActionReturn,
            onTap: onReturn,
          ),
        ],
      ),
    );
  }
}

class _MovementForm extends StatefulWidget {
  final MovementEntity? movement;

  const _MovementForm({this.movement});

  @override
  State<_MovementForm> createState() => _MovementFormState();
}

class _MovementFormState extends State<_MovementForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();

  ProductEntity? _selectedProduct;
  String? _selectedProductName;
  MovementType _type = MovementType.entry;
  DateTime _movementDate = DateTime.now();
  bool _isSaving = false;

  bool get _isEditing => widget.movement != null;

  @override
  void initState() {
    super.initState();
    final movement = widget.movement;
    if (movement != null) {
      final products = context.read<ProductProvider>().products;
      try {
        _selectedProduct = products.firstWhere(
          (product) => product.id == movement.product.id,
        );
      } catch (_) {
        _selectedProduct = movement.product;
      }
      _selectedProductName = movement.product.name;
      _type = movement.type;
      _movementDate = movement.movementDate;
      _quantityController.text = movement.quantity.toString();
      _descriptionController.text = movement.observation ?? '';
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _movementDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _movementDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProduct == null) return;

    setState(() => _isSaving = true);
    try {
      final quantity = int.parse(_quantityController.text.trim());
      final description = _descriptionController.text.trim();
      final movementProvider = context.read<MovementProvider>();

      if (_isEditing) {
        await movementProvider.editMovement(
          oldMovement: widget.movement!,
          type: _type,
          quantity: quantity,
          movementDate: _movementDate,
          observation: description.isEmpty ? null : description,
        );
      } else {
        await movementProvider.createMovement(
          product: _selectedProduct!,
          type: _type,
          quantity: quantity,
          movementDate: _movementDate,
          observation: description.isEmpty ? null : description,
        );
      }

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.movementSaveErrorPrefix(describeError(e, l10n))),
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
    final products = context.watch<ProductProvider>().products;
    final warehouses = context.watch<WarehouseProvider>().warehouses;

    final productNames = products.map((product) => product.name).toSet().toList()
      ..sort();

    final warehouseOptions = _selectedProductName == null
        ? <ProductEntity>[]
        : products
              .where((product) => product.name == _selectedProductName)
              .toList();

    String warehouseName(String warehouseId) {
      for (final warehouse in warehouses) {
        if (warehouse.id == warehouseId) return warehouse.name;
      }
      return warehouseId;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            DropdownFieldWidget<String>(
              label: l10n.productTitle,
              value: _selectedProductName,
              isMandatory: true,
              items: productNames.map((name) {
                return DropdownMenuItem<String>(value: name, child: Text(name));
              }).toList(),
              onChanged: _isEditing
                  ? null
                  : (name) {
                      final matches = products
                          .where((product) => product.name == name)
                          .toList();
                      setState(() {
                        _selectedProductName = name;
                        _selectedProduct = matches.length == 1
                            ? matches.first
                            : null;
                      });
                    },
              validator: (value) {
                if (value == null) return l10n.movementValidatorProductRequired;
                return null;
              },
            ),
            DropdownFieldWidget<ProductEntity>(
              label: l10n.warehouseTitle,
              value: _selectedProduct,
              isMandatory: true,
              items: warehouseOptions.map((product) {
                return DropdownMenuItem<ProductEntity>(
                  value: product,
                  child: Text(warehouseName(product.warehouseId)),
                );
              }).toList(),
              onChanged: (_isEditing || _selectedProductName == null)
                  ? null
                  : (product) => setState(() => _selectedProduct = product),
              validator: (value) {
                if (value == null) {
                  return l10n.productValidatorWarehouseRequired;
                }
                return null;
              },
            ),
            TextFieldWidget(
              label: l10n.commonDescriptionLabel,
              controller: _descriptionController,
              isMandatory: true,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.movementDateLabel,
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(_formatDate(_movementDate)),
                ),
              ),
            ),
            TextFieldWidget(
              label: l10n.movementQuantityLabel,
              controller: _quantityController,
              isMandatory: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = int.tryParse(value?.trim() ?? '');
                if (parsed == null || parsed <= 0) {
                  return l10n.movementValidatorQuantityRequired;
                }
                return null;
              },
            ),
            RadioGroup<MovementType>(
              groupValue: _type,
              onChanged: (value) => setState(() => _type = value!),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<MovementType>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.movementTypeEntry),
                      value: MovementType.entry,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<MovementType>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.movementTypeExit),
                      value: MovementType.exit,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _isSaving ? null : _save,
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
                            l10n.commonSave,
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
    );
  }
}

class _MovementList extends StatelessWidget {
  final bool removeMode;
  final bool returnMode;
  final void Function(MovementEntity movement)? onTapMovement;

  const _MovementList({
    this.removeMode = false,
    this.returnMode = false,
    this.onTapMovement,
  });

  Future<void> _confirmDelete(
    BuildContext context,
    MovementEntity movement,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.movementDeleteTitle),
        content: Text(l10n.movementDeleteContent(movement.product.name)),
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

    if (confirmed == true && context.mounted) {
      try {
        await context.read<MovementProvider>().deleteMovement(movement);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.movementDeleteErrorPrefix(describeError(e, l10n)),
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> _confirmReturn(
    BuildContext context,
    MovementEntity movement,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.movementReturnConfirmTitle),
        content: Text(
          l10n.movementReturnConfirmContent(
            movement.quantity,
            movement.product.name,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.movementActionReturn),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await context.read<MovementProvider>().returnMovement(movement);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.movementReturnErrorPrefix(describeError(e, l10n)),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<MovementProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return Center(child: Text(describeError(provider.error!, l10n)));
    }

    final movements = returnMode
        ? provider.movements
              .where((m) => m.type == MovementType.exit && !m.returned)
              .toList()
        : provider.movements;

    if (movements.isEmpty) {
      return Center(
        child: Text(
          returnMode ? l10n.movementReturnEmptyList : l10n.movementEmptyList,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: MovementLeadingIndicator(movement: movement),
            title: Text(movement.product.name),
            subtitle: Text(
              '${formatMovementDate(movement.movementDate)} • '
              '${l10n.movementQtyInlineLabel}: ${movement.quantity}'
              '${movement.observation != null && movement.observation!.isNotEmpty ? ' • ${movement.observation}' : ''}'
              '${movement.returned ? ' • ${l10n.movementReturnedTag}' : ''}',
            ),
            trailing: removeMode
                ? IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _confirmDelete(context, movement),
                  )
                : returnMode
                ? IconButton(
                    icon: const Icon(Icons.keyboard_return),
                    onPressed: () => _confirmReturn(context, movement),
                  )
                : const Icon(Icons.chevron_right),
            onTap: () {
              if (removeMode || returnMode) {
                showMovementDetailsDialog(context, movement);
              } else {
                onTapMovement?.call(movement);
              }
            },
          ),
        );
      },
    );
  }
}
