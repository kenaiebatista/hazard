import 'package:hazard/domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final List<CategoryEntity> _categories = [];

  @override
  Future<List<CategoryEntity>> getAll() async {
    return List.unmodifiable(_categories);
  }

  @override
  Future<void> save(CategoryEntity category) async {
    final index = _categories.indexWhere((c) => c.id == category.id);

    if (index == -1) {
      _categories.add(category);
    } else {
      _categories[index] = category;
    }
  }

  @override
  Future<void> delete(String id) async {
    _categories.removeWhere((category) => category.id == id);
  }
}