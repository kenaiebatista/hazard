import 'package:hazard/domain/entities/entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';

class MovementEntity extends Entity {
  final ProductEntity product;
  final MovementType type;
  final int quantity;
  final DateTime movementDate;
  final String? observation;
  final bool returned;

  MovementEntity({
    String? id,
    required this.product,
    required this.type,
    required this.quantity,
    DateTime? movementDate,
    this.observation,
    this.returned = false,
  }) : assert(quantity > 0, 'A quantidade deve ser maior que zero'),
       movementDate = movementDate ?? DateTime.now(),
       super(id: id);
}
