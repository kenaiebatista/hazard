import 'package:hazard/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<void> save(ProductEntity product);

  Future<List<ProductEntity>> getAll();

  Future<void> delete(String id);

  Future<ProductEntity?> getByWarehouseAndSku(
      String warehouseId,
      String sku,
      );
}
