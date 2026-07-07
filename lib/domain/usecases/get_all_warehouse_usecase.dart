import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/repositories/warehouse_repository.dart';

class GetAllWarehouses {
  final WarehouseRepository repository;

  GetAllWarehouses(this.repository);

  Future<List<WarehouseEntity>> call() {
    return repository.getAll();
  }
}