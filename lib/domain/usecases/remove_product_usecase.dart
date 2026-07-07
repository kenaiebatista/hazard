import 'package:hazard/domain/repositories/product_repository.dart';

class RemoveProduct {
  final ProductRepository repository;

  RemoveProduct(this.repository);

  Future<void> call(String id) {
    return repository.delete(id);
  }
}