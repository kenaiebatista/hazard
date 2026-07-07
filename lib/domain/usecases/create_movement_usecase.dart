import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class CreateMovementUseCase {
  final MovementRepository _movementRepository;
  final ProductRepository _productRepository;

  CreateMovementUseCase({
    required MovementRepository movementRepository,
    required ProductRepository productRepository,
  }) : _movementRepository = movementRepository,
       _productRepository = productRepository;

  Future<void> call(MovementEntity movement) async {
    final product = await _productRepository.getByWarehouseAndSku(
      movement.product.warehouseId,
      movement.product.sku,
    );

    if (product == null) {
      throw Exception('Produto não encontrado.');
    }

    int newAmount = product.amount ?? 0;

    switch (movement.type) {
      case MovementType.entry:
        newAmount += movement.quantity;
        break;

      case MovementType.exit:
        if (product.amount! < movement.quantity) {
          throw Exception('Estoque insuficiente.');
        }
        newAmount -= movement.quantity;
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
      amount: newAmount,
    );

    await _productRepository.save(updatedProduct);

    await _movementRepository.createMovement(movement);
  }
}
