import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class UpdateMovementUseCase {
  final MovementRepository _movementRepository;
  final ProductRepository _productRepository;

  UpdateMovementUseCase({
    required MovementRepository movementRepository,
    required ProductRepository productRepository,
  }) : _movementRepository = movementRepository,
       _productRepository = productRepository;

  Future<void> call(MovementEntity oldMovement, MovementEntity newMovement) async {
    final product = await _productRepository.getByWarehouseAndSku(
      oldMovement.product.warehouseId,
      oldMovement.product.sku,
    );

    if (product == null) {
      throw Exception('Produto não encontrado.');
    }

    int amount = product.amount ?? 0;

    switch (oldMovement.type) {
      case MovementType.entry:
        amount -= oldMovement.quantity;
        break;
      case MovementType.exit:
        amount += oldMovement.quantity;
        break;
    }

    switch (newMovement.type) {
      case MovementType.entry:
        amount += newMovement.quantity;
        break;
      case MovementType.exit:
        if (amount < newMovement.quantity) {
          throw Exception('Estoque insuficiente.');
        }
        amount -= newMovement.quantity;
        break;
    }

    final updatedProduct = ProductEntity(
      id: product.id,
      name: product.name,
      description: product.description,
      sku: product.sku,
      categoryId: product.categoryId,
      subcategoryId: product.subcategoryId,
      warehouseId: product.warehouseId,
      amount: amount,
    );

    await _productRepository.save(updatedProduct);
    await _movementRepository.updateMovement(newMovement);
  }
}
