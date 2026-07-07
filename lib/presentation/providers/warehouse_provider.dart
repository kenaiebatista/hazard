import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/usecases/create_warehouse_usecase.dart';
import 'package:hazard/domain/usecases/get_all_warehouse_usecase.dart';
import 'package:hazard/domain/usecases/remove_warehouse_usecase.dart';

class WarehouseProvider extends ChangeNotifier {
  final CreateWarehouseUsecase _createWarehouse;
  final GetAllWarehouses _getAllWarehouses;
  final RemoveWarehouse _removeWarehouse;

  WarehouseProvider({
    required CreateWarehouseUsecase createWarehouse,
    required GetAllWarehouses getAllWarehouses,
    required RemoveWarehouse removeWarehouse,
  }) : _createWarehouse = createWarehouse,
       _getAllWarehouses = getAllWarehouses,
       _removeWarehouse = removeWarehouse;

  List<WarehouseEntity> _warehouses = [];
  bool _isLoading = false;
  String? _error;

  bool _isSelecting = false;
  final Set<String> _selectedIds = {};

  List<WarehouseEntity> get warehouses => List.unmodifiable(_warehouses);

  bool get isLoading => _isLoading;

  String? get error => _error;

  bool get isSelecting => _isSelecting;

  Set<String> get selectedIds => Set.unmodifiable(_selectedIds);

  bool isSelected(String id) => _selectedIds.contains(id);

  void startSelecting() {
    _isSelecting = true;
    _selectedIds.clear();
    notifyListeners();
  }

  void stopSelecting() {
    _isSelecting = false;
    _selectedIds.clear();
    notifyListeners();
  }

  void toggleSelection(String id) {
    if (!_selectedIds.remove(id)) {
      _selectedIds.add(id);
    }
    notifyListeners();
  }

  Future<void> loadWarehouses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _warehouses = (await _getAllWarehouses()).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createWarehouse({
    required String name,
    required String cep,
    required String street,
    String number = '',
    String complement = '',
    required String neighborhood,
    required String city,
    required String state,
    required int capacity,
  }) async {
    final warehouse = WarehouseEntity(
      name: name,
      cep: cep,
      street: street,
      number: number,
      complement: complement,
      neighborhood: neighborhood,
      city: city,
      state: state,
      capacity: capacity,
    );
    await _createWarehouse(warehouse);
    await loadWarehouses();
  }

  Future<void> updateWarehouse({
    required String id,
    required String name,
    required String cep,
    required String street,
    String number = '',
    String complement = '',
    required String neighborhood,
    required String city,
    required String state,
    required int capacity,
  }) async {
    final warehouse = WarehouseEntity(
      id: id,
      name: name,
      cep: cep,
      street: street,
      number: number,
      complement: complement,
      neighborhood: neighborhood,
      city: city,
      state: state,
      capacity: capacity,
    );
    await _createWarehouse(warehouse);
    await loadWarehouses();
  }

  Future<void> deleteSelectedWarehouses() async {
    for (final id in _selectedIds) {
      await _removeWarehouse(id);
    }
    _isSelecting = false;
    _selectedIds.clear();
    await loadWarehouses();
  }
}
