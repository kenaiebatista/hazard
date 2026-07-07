import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/repositories/warehouse_repository.dart';

class CreateWarehouseUsecase {
  final WarehouseRepository repository;

  CreateWarehouseUsecase(this.repository);

  Future<void> call(WarehouseEntity warehouse) {
    return repository.save(warehouse);
  }
}