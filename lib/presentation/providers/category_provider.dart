import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/entities/subcategory_entity.dart';
import 'package:hazard/domain/usecases/create_category_usecase.dart';
import 'package:hazard/domain/usecases/get_all_category_usecase.dart';
import 'package:hazard/domain/usecases/remove_category_usecase.dart';

class CategoryProvider extends ChangeNotifier {
  final CreateCategoryUsecase _createCategory;
  final GetAllCategories _getAllCategories;
  final RemoveCategory _removeCategory;

  CategoryProvider({
    required CreateCategoryUsecase createCategory,
    required GetAllCategories getAllCategories,
    required RemoveCategory removeCategory,
  }) : _createCategory = createCategory,
       _getAllCategories = getAllCategories,
       _removeCategory = removeCategory;

  List<CategoryEntity> _categories = [];
  bool _isLoading = false;
  String? _error;

  bool _isSelecting = false;
  final Set<String> _selectedIds = {};

  List<CategoryEntity> get categories => List.unmodifiable(_categories);

  bool get isLoading => _isLoading;

  String? get error => _error;

  bool get isSelecting => _isSelecting;

  Set<String> get selectedIds => Set.unmodifiable(_selectedIds);

  bool isSelected(String id) => _selectedIds.contains(id);

  void startSelecting() {
    _isSelecting = true;
    _selectedIds.clear();
    notifyListeners();
  }

  void stopSelecting() {
    _isSelecting = false;
    _selectedIds.clear();
    notifyListeners();
  }

  void toggleSelection(String id) {
    if (!_selectedIds.remove(id)) {
      _selectedIds.add(id);
    }
    notifyListeners();
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = (await _getAllCategories()).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCategory({
    required String name,
    required List<SubcategoryEntity>subcategories,
  }) async {
    final category = CategoryEntity(name: name, subcategories: subcategories);
    await _createCategory(category);
    await loadCategories();
  }

  Future<void> updateCategory({
    required String id,
    required String name,
    required List<SubcategoryEntity> subcategories,
  }) async {
    final category = CategoryEntity(
      id: id,
      name: name,
      subcategories: subcategories,
    );
    await _createCategory(category);
    await loadCategories();
  }

  Future<void> deleteSelectedCategories() async {
    for (final id in _selectedIds) {
      await _removeCategory(id);
    }
    _isSelecting = false;
    _selectedIds.clear();
    await loadCategories();
  }
}
