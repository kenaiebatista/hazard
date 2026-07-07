import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getAll();
  }
}