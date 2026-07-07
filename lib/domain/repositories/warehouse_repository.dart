import 'package:hazard/domain/entities/warehouse_entity.dart';

abstract class WarehouseRepository {
  Future<void> save(WarehouseEntity warehouse);

  Future<List<WarehouseEntity>> getAll();

  Future<void> delete(String id);
}