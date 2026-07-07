import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<ProductEntity> _products = [];

  @override
  Future<List<ProductEntity>> getAll() async {
    return List.unmodifiable(_products);
  }

  @override
  Future<void> save(ProductEntity product) async {
    final index = _products.indexWhere(
          (p) => p.id == product.id,
    );

    if (index == -1) {
      _products.add(product);
    } else {
      _products[index] = product;
    }
  }

  @override
  Future<void> delete(String id) async {
    _products.removeWhere((product) => product.id == id);
  }

  @override
  Future<ProductEntity?> getByWarehouseAndSku(String warehouseId,
      String sku,) async {
    try {
      return _products.firstWhere(
            (product) =>
        product.warehouseId == warehouseId &&
            product.sku == sku,
      );
    } catch (_) {
      return null;
    }
  }
}