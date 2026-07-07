import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';

class GetAllMovements {
  final MovementRepository repository;

  GetAllMovements(this.repository);

  Future<List<MovementEntity>> call() {
    return repository.getAllMovements();
  }
}
