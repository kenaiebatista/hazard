import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hazard/presentation/errors/error_translator.dart';
import 'package:hazard/data/datasources/viacep_datasource.dart';
import 'package:hazard/data/repositories/address_repository_impl.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/usecases/get_address_by_cep_usecase.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';

class WarehouseRightsideWidget extends StatefulWidget {
  final WarehouseEntity? warehouse;
  final VoidCallback? onDone;

  const WarehouseRightsideWidget({super.key, this.warehouse, this.onDone});

  @override
  State<WarehouseRightsideWidget> createState() =>
      _WarehouseRightsideWidgetState();
}

class _WarehouseRightsideWidgetState extends State<WarehouseRightsideWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _capacityController = TextEditingController();

  final _getAddressByCep = GetAddressByCepUsecase(
    AddressRepositoryImpl(ViaCepDataSource()),
  );

  bool _isSaving = false;
  bool _isSearchingCep = false;
  String? _cepError;

  bool get _isEditing => widget.warehouse != null;

  @override
  void initState() {
    super.initState();
    final warehouse = widget.warehouse;
    if (warehouse != null) {
      _nameController.text = warehouse.name;
      _cepController.text = warehouse.cep;
      _streetController.text = warehouse.street;
      _numberController.text = warehouse.number;
      _complementController.text = warehouse.complement;
      _neighborhoodController.text = warehouse.neighborhood;
      _cityController.text = warehouse.city;
      _stateController.text = warehouse.state;
      _capacityController.text = warehouse.capacity.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _searchCep() async {
    final l10n = AppLocalizations.of(context);
    final cep = _cepController.text.trim();
    if (cep.length != 8) {
      setState(() => _cepError = l10n.warehouseCepDigitsError);
      return;
    }

    setState(() {
      _isSearchingCep = true;
      _cepError = null;
    });

    try {
      final address = await _getAddressByCep(cep);
      if (address == null) {
        setState(() => _cepError = l10n.warehouseCepNotFound);
        return;
      }
      _streetController.text = address.street;
      _neighborhoodController.text = address.neighborhood;
      _cityController.text = address.city;
      _stateController.text = address.state;
    } catch (e) {
      setState(() => _cepError = l10n.warehouseCepSearchError);
    } finally {
      if (mounted) setState(() => _isSearchingCep = false);
    }
  }

  Future<void> _saveWarehouse() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final warehouseProvider = context.read<WarehouseProvider>();

      if (_isEditing) {
        await warehouseProvider.updateWarehouse(
          id: widget.warehouse!.id,
          name: _nameController.text.trim(),
          cep: _cepController.text.trim(),
          street: _streetController.text.trim(),
          number: _numberController.text.trim(),
          complement: _complementController.text.trim(),
          neighborhood: _neighborhoodController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          capacity: int.parse(_capacityController.text.trim()),
        );
      } else {
        await warehouseProvider.createWarehouse(
          name: _nameController.text.trim(),
          cep: _cepController.text.trim(),
          street: _streetController.text.trim(),
          number: _numberController.text.trim(),
          complement: _complementController.text.trim(),
          neighborhood: _neighborhoodController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          capacity: int.parse(_capacityController.text.trim()),
        );
      }
      widget.onDone?.call();
      if (mounted) context.go('/warehouse');
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.warehouseSaveErrorPrefix(describeError(e, l10n)),
            ),
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
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                TextFieldWidget(
                  label: l10n.commonNameLabel,
                  controller: _nameController,
                  isMandatory: true,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.commonValidatorNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  label: l10n.warehouseCepLabel,
                  controller: _cepController,
                  isMandatory: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  onChanged: (value) {
                    if (_cepError != null) setState(() => _cepError = null);
                    if (value.length == 8) _searchCep();
                  },
                  suffixIcon: _isSearchingCep
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _searchCep,
                        ),
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        value.trim().length != 8) {
                      return l10n.warehouseValidatorCepInvalid;
                    }
                    return null;
                  },
                ),
                if (_cepError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        _cepError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  label: l10n.warehouseStreetLabel,
                  controller: _streetController,
                  isMandatory: true,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.warehouseValidatorStreetRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        label: l10n.warehouseNumberLabel,
                        controller: _numberController,
                        isMandatory: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFieldWidget(
                        label: l10n.warehouseComplementLabel,
                        controller: _complementController,
                        isMandatory: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  label: l10n.warehouseNeighborhoodLabel,
                  controller: _neighborhoodController,
                  isMandatory: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.warehouseValidatorNeighborhoodRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFieldWidget(
                        label: l10n.warehouseCityLabel,
                        controller: _cityController,
                        isMandatory: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.warehouseValidatorCityRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(
                        label: l10n.warehouseStateLabel,
                        controller: _stateController,
                        isMandatory: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().length != 2) {
                            return l10n.warehouseStateLabel;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  label: l10n.warehouseCapacityLabel,
                  controller: _capacityController,
                  isMandatory: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    final parsed = value == null
                        ? null
                        : int.tryParse(value.trim());
                    if (parsed == null || parsed < 0) {
                      return l10n.warehouseValidatorCapacityRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: _isSaving ? null : _saveWarehouse,
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
                if (_isEditing)
                  TextButton(
                    onPressed: _isSaving ? null : widget.onDone,
                    child: Text(l10n.warehouseCancelEdit),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
