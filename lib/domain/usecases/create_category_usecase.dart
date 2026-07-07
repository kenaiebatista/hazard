import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/repositories/category_repository.dart';

class CreateCategoryUsecase {
  final CategoryRepository repository;

  CreateCategoryUsecase(this.repository);

  Future<void> call(CategoryEntity category) {
    return repository.save(category);
  }
}
