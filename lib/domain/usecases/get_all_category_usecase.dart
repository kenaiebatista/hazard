import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getAll();
  }
}
