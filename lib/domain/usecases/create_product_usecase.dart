import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/repositories/product_repository.dart';

class CreateProductUsecase {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  Future<void> call(ProductEntity product) {
    return repository.save(product);
  }
}
