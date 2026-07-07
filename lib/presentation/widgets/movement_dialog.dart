import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/presentation/providers/movement_provider.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';

enum _MovementView { menu, add, editList, editForm, removeList }

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
    });
  }

  void _goTo(_MovementView view, {MovementEntity? movement}) {
    setState(() {
      _view = view;
      _editingMovement = movement;
    });
  }

  String get _title {
    switch (_view) {
      case _MovementView.menu:
        return 'Movimentações de Estoque';
      case _MovementView.add:
        return 'Adicionar Movimentação';
      case _MovementView.editList:
        return 'Editar Movimentação';
      case _MovementView.editForm:
        return 'Editar Movimentação';
      case _MovementView.removeList:
        return 'Remover Movimentação';
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 480,
        constraints: const BoxConstraints(maxHeight: 640),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(-15658620)),
          color: Colors.white,
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
                      _title,
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
              const Divider(color: Color(-15658620)),
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
    }
  }
}

class _MovementMenu extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const _MovementMenu({
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuButton(icon: Icons.add, label: 'Adicionar', onTap: onAdd),
          _MenuButton(icon: Icons.edit, label: 'Editar', onTap: onEdit),
          _MenuButton(
            icon: Icons.delete_outline,
            label: 'Remover',
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(-15658620),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
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
  MovementType _type = MovementType.entry;
  DateTime _movementDate = DateTime.now();
  bool _isSaving = false;

  bool get _isEditing => widget.movement != null;

  @override
  void initState() {
    super.initState();
    final movement = widget.movement;
    if (movement != null) {
      _selectedProduct = movement.product;
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar movimentação: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            DropdownButtonFormField<ProductEntity>(
              initialValue: _selectedProduct,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              items: products.map((product) {
                return DropdownMenuItem<ProductEntity>(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
              onChanged: _isEditing
                  ? null
                  : (product) => setState(() => _selectedProduct = product),
              validator: (value) {
                if (value == null) return 'Selecione um produto';
                return null;
              },
            ),
            TextFieldWidget(
              label: 'Descrição',
              controller: _descriptionController,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(_formatDate(_movementDate)),
                ),
              ),
            ),
            TextFieldWidget(
              label: 'Quantidade',
              controller: _quantityController,
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = int.tryParse(value?.trim() ?? '');
                if (parsed == null || parsed <= 0) {
                  return 'Informe uma quantidade válida';
                }
                return null;
              },
            ),
            RadioGroup<MovementType>(
              groupValue: _type,
              onChanged: (value) => setState(() => _type = value!),
              child: Row(
                children: const [
                  Expanded(
                    child: RadioListTile<MovementType>(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Adicionar'),
                      value: MovementType.entry,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<MovementType>(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Remover'),
                      value: MovementType.exit,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: const Color(-15658620),
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
                        : const Text(
                            'Salvar',
                            style: TextStyle(
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
  final void Function(MovementEntity movement)? onTapMovement;

  const _MovementList({this.removeMode = false, this.onTapMovement});

  Future<void> _confirmDelete(
    BuildContext context,
    MovementEntity movement,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remover movimentação'),
        content: Text(
          'Deseja remover a movimentação de "${movement.product.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<MovementProvider>().deleteMovement(movement);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovementProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }
    if (provider.movements.isEmpty) {
      return const Center(child: Text('Nenhuma movimentação registrada.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: provider.movements.length,
      itemBuilder: (context, index) {
        final movement = provider.movements[index];
        final isEntry = movement.type == MovementType.entry;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              isEntry ? Icons.arrow_downward : Icons.arrow_upward,
              color: isEntry ? Colors.green : Colors.red,
            ),
            title: Text(movement.product.name),
            subtitle: Text(
              '${_formatDate(movement.movementDate)} • Qtd: ${movement.quantity}'
              '${movement.observation != null && movement.observation!.isNotEmpty ? ' • ${movement.observation}' : ''}',
            ),
            trailing: removeMode
                ? IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _confirmDelete(context, movement),
                  )
                : const Icon(Icons.chevron_right),
            onTap: removeMode ? null : () => onTapMovement?.call(movement),
          ),
        );
      },
    );
  }
}
