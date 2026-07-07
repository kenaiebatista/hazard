import 'package:hazard/domain/entities/warehouse_entity.dart';
import '../../domain/repositories/warehouse_repository.dart';

class WarehouseRepositoryImpl implements WarehouseRepository {
  final List<WarehouseEntity> _warehouses = [];

  @override
  Future<List<WarehouseEntity>> getAll() async {
    return List.unmodifiable(_warehouses);
  }

  @override
  Future<void> save(WarehouseEntity warehouse) async {
    final index = _warehouses.indexWhere((w) => w.id == warehouse.id);

    if (index == -1) {
      _warehouses.add(warehouse);
    } else {
      _warehouses[index] = warehouse;
    }
  }

  @override
  Future<void> delete(String id) async {
    _warehouses.removeWhere((warehouse) => warehouse.id == id);
  }
}