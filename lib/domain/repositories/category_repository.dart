import 'package:hazard/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<void> save(CategoryEntity category);

  Future<List<CategoryEntity>> getAll();

  Future<void> delete(String id);
}