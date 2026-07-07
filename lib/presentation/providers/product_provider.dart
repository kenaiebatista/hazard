import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/usecases/create_product_usecase.dart';
import 'package:hazard/domain/usecases/get_all_product_usecase.dart';
import 'package:hazard/domain/usecases/remove_product_usecase.dart';

class ProductProvider extends ChangeNotifier {
  final CreateProductUsecase _createProduct;
  final GetAllProducts _getAllProducts;
  final RemoveProduct _removeProduct;

  ProductProvider({
    required CreateProductUsecase createProduct,
    required GetAllProducts getAllProducts,
    required RemoveProduct removeProduct,
  }) : _createProduct = createProduct,
       _getAllProducts = getAllProducts,
       _removeProduct = removeProduct;

  List<ProductEntity> _products = [];
  bool _isLoading = false;
  String? _error;

  bool _isSelecting = false;
  final Set<String> _selectedIds = {};

  List<ProductEntity> get products => List.unmodifiable(_products);

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

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = (await _getAllProducts()).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required String sku,
    required String categoryId,
    required String subcategoryId,
    required String warehouseId,
  }) async {
    final product = ProductEntity(
      name: name,
      description: description,
      sku: sku,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      warehouseId: warehouseId,
    );
    await _createProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required String description,
    required String sku,
    required String categoryId,
    required String subcategoryId,
    required String warehouseId,
    int? amount,
  }) async {
    final product = ProductEntity(
      id: id,
      name: name,
      description: description,
      sku: sku,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      warehouseId: warehouseId,
      amount: amount,
    );
    await _createProduct(product);
    await loadProducts();
  }

  Future<void> deleteSelectedProducts() async {
    for (final id in _selectedIds) {
      await _removeProduct(id);
    }
    _isSelecting = false;
    _selectedIds.clear();
    await loadProducts();
  }
}
