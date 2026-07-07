import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';

class MovementRepositoryImpl implements MovementRepository {
  final List<MovementEntity> _movements = [];

  @override
  Future<void> createMovement(MovementEntity movement) async {
    _movements.add(movement);
  }

  @override
  Future<void> updateMovement(MovementEntity movement) async {
    final index = _movements.indexWhere((m) => m.id == movement.id);

    if (index != -1) {
      _movements[index] = movement;
    }
  }

  @override
  Future<void> deleteMovement(String id) async {
    _movements.removeWhere((movement) => movement.id == id);
  }

  @override
  Future<List<MovementEntity>> getAllMovements() async {
    return List.unmodifiable(_movements);
  }

  @override
  Future<MovementEntity?> getMovementById(String id) async {
    try {
      return _movements.firstWhere((movement) => movement.id == id);
    } catch (_) {
      return null;
    }
  }
}