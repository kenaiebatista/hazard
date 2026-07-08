import 'package:hazard/core/errors/app_exception.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class ReturnMovementUseCase {
  final MovementRepository _movementRepository;
  final ProductRepository _productRepository;

  ReturnMovementUseCase({
    required MovementRepository movementRepository,
    required ProductRepository productRepository,
  }) : _movementRepository = movementRepository,
       _productRepository = productRepository;

  Future<void> call(MovementEntity movement) async {
    if (movement.type != MovementType.exit) {
      throw const AppException(AppErrorKey.onlyExitMovementsCanBeReturned);
    }

    if (movement.returned) {
      throw const AppException(AppErrorKey.movementAlreadyReturned);
    }

    final product = await _productRepository.getByWarehouseAndSku(
      movement.product.warehouseId,
      movement.product.sku,
    );

    if (product == null) {
      throw const AppException(AppErrorKey.productNotFound);
    }

    final updatedProduct = ProductEntity(
      id: product.id,
      name: product.name,
      description: product.description,
      sku: product.sku,
      categoryId: product.categoryId,
      subcategoryId: product.subcategoryId,
      warehouseId: product.warehouseId,
      amount: (product.amount ?? 0) + movement.quantity,
      imageUrl: product.imageUrl,
    );

    await _productRepository.save(updatedProduct);

    final returnedMovement = MovementEntity(
      id: movement.id,
      product: movement.product,
      type: movement.type,
      quantity: movement.quantity,
      movementDate: movement.movementDate,
      observation: movement.observation,
      returned: true,
    );

    await _movementRepository.updateMovement(returnedMovement);
  }
}
