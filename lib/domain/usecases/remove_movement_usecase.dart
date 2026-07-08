import 'package:hazard/core/errors/app_exception.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class RemoveMovementUseCase {
  final MovementRepository _movementRepository;
  final ProductRepository _productRepository;

  RemoveMovementUseCase({
    required MovementRepository movementRepository,
    required ProductRepository productRepository,
  }) : _movementRepository = movementRepository,
       _productRepository = productRepository;

  Future<void> call(MovementEntity movement) async {
    if (movement.returned) {
      throw const AppException(AppErrorKey.movementAlreadyReturnedForRemoval);
    }

    final product = await _productRepository.getByWarehouseAndSku(
      movement.product.warehouseId,
      movement.product.sku,
    );

    if (product != null) {
      int amount = product.amount ?? 0;

      switch (movement.type) {
        case MovementType.entry:
          amount -= movement.quantity;
          break;
        case MovementType.exit:
          amount += movement.quantity;
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
        imageUrl: product.imageUrl,
      );

      await _productRepository.save(updatedProduct);
    }

    await _movementRepository.deleteMovement(movement.id);
  }
}
