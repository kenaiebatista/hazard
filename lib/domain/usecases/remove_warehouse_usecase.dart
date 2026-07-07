import 'package:hazard/domain/repositories/warehouse_repository.dart';

class RemoveWarehouse {
  final WarehouseRepository repository;

  RemoveWarehouse(this.repository);

  Future<void> call(String id) {
    return repository.delete(id);
  }
}