import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/usecases/create_movement_usecase.dart';
import 'package:hazard/domain/usecases/get_all_movements_usecase.dart';
import 'package:hazard/domain/usecases/remove_movement_usecase.dart';
import 'package:hazard/domain/usecases/return_movement_usecase.dart';
import 'package:hazard/domain/usecases/update_movement_usecase.dart';

class MovementProvider extends ChangeNotifier {
  final CreateMovementUseCase _createMovement;
  final GetAllMovements _getAllMovements;
  final UpdateMovementUseCase _updateMovement;
  final RemoveMovementUseCase _removeMovement;
  final ReturnMovementUseCase _returnMovement;

  MovementProvider({
    required CreateMovementUseCase createMovement,
    required GetAllMovements getAllMovements,
    required UpdateMovementUseCase updateMovement,
    required RemoveMovementUseCase removeMovement,
    required ReturnMovementUseCase returnMovement,
  }) : _createMovement = createMovement,
       _getAllMovements = getAllMovements,
       _updateMovement = updateMovement,
       _removeMovement = removeMovement,
       _returnMovement = returnMovement;

  List<MovementEntity> _movements = [];
  bool _isLoading = false;
  Object? _error;

  List<MovementEntity> get movements => List.unmodifiable(_movements);

  bool get isLoading => _isLoading;

  Object? get error => _error;

  Future<void> loadMovements() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movements = (await _getAllMovements()).toList()
        ..sort((a, b) => b.movementDate.compareTo(a.movementDate));
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createMovement({
    required ProductEntity product,
    required MovementType type,
    required int quantity,
    required DateTime movementDate,
    String? observation,
  }) async {
    final movement = MovementEntity(
      product: product,
      type: type,
      quantity: quantity,
      movementDate: movementDate,
      observation: observation,
    );
    await _createMovement(movement);
    await loadMovements();
  }

  Future<void> editMovement({
    required MovementEntity oldMovement,
    required MovementType type,
    required int quantity,
    required DateTime movementDate,
    String? observation,
  }) async {
    final newMovement = MovementEntity(
      id: oldMovement.id,
      product: oldMovement.product,
      type: type,
      quantity: quantity,
      movementDate: movementDate,
      observation: observation,
      returned: oldMovement.returned,
    );
    await _updateMovement(oldMovement, newMovement);
    await loadMovements();
  }

  Future<void> deleteMovement(MovementEntity movement) async {
    await _removeMovement(movement);
    await loadMovements();
  }

  Future<void> returnMovement(MovementEntity movement) async {
    await _returnMovement(movement);
    await loadMovements();
  }
}
