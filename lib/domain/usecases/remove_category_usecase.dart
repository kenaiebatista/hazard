import 'package:hazard/domain/repositories/category_repository.dart';

class RemoveCategory {
  final CategoryRepository repository;

  RemoveCategory(this.repository);

  Future<void> call(String id) {
    return repository.delete(id);
  }
}
