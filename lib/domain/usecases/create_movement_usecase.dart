import 'package:hazard/core/errors/app_exception.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/repositories/movement_repository.dart';
import 'package:hazard/domain/repositories/product_repository.dart';
import 'package:hazard/domain/repositories/warehouse_repository.dart';

class CreateMovementUseCase {
  final MovementRepository _movementRepository;
  final ProductRepository _productRepository;
  final WarehouseRepository _warehouseRepository;

  CreateMovementUseCase({
    required MovementRepository movementRepository,
    required ProductRepository productRepository,
    required WarehouseRepository warehouseRepository,
  }) : _movementRepository = movementRepository,
       _productRepository = productRepository,
       _warehouseRepository = warehouseRepository;

  Future<void> call(MovementEntity movement) async {
    final product = await _productRepository.getByWarehouseAndSku(
      movement.product.warehouseId,
      movement.product.sku,
    );

    if (product == null) {
      throw const AppException(AppErrorKey.productNotFound);
    }

    int newAmount = product.amount ?? 0;

    switch (movement.type) {
      case MovementType.entry:
        newAmount += movement.quantity;
        break;

      case MovementType.exit:
        if (newAmount < movement.quantity) {
          throw AppException(AppErrorKey.insufficientStock, [
            product.name,
            newAmount,
            movement.quantity,
          ]);
        }
        newAmount -= movement.quantity;
        break;
    }

    if (movement.type == MovementType.entry) {
      await _assertWithinWarehouseCapacity(
        warehouseId: product.warehouseId,
        currentProductId: product.id,
        newAmountForCurrentProduct: newAmount,
      );
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
      imageUrl: product.imageUrl,
    );

    await _productRepository.save(updatedProduct);

    await _movementRepository.createMovement(movement);
  }

  Future<void> _assertWithinWarehouseCapacity({
    required String warehouseId,
    required String currentProductId,
    required int newAmountForCurrentProduct,
  }) async {
    final warehouses = await _warehouseRepository.getAll();
    WarehouseEntity? warehouse;
    for (final w in warehouses) {
      if (w.id == warehouseId) {
        warehouse = w;
        break;
      }
    }
    if (warehouse == null) return;

    final products = await _productRepository.getAll();
    final total = newAmountForCurrentProduct +
        products
            .where(
              (p) => p.warehouseId == warehouseId && p.id != currentProductId,
            )
            .fold<int>(0, (sum, p) => sum + p.amount);

    if (total > warehouse.capacity) {
      throw AppException(AppErrorKey.warehouseCapacityExceeded, [
        warehouse.name,
        warehouse.capacity,
        total,
      ]);
    }
  }
}
