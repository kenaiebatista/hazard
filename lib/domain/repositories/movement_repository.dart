import 'package:hazard/domain/entities/movement_entity.dart';

abstract class MovementRepository{
  Future<void> createMovement(MovementEntity movement);

  Future<void> updateMovement(MovementEntity movement);

  Future<void> deleteMovement(String id);

  Future<List<MovementEntity>> getAllMovements();

  Future<MovementEntity?> getMovementById(String id);
}