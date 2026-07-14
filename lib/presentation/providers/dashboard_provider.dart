import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/category_entity.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';
import 'package:hazard/domain/entities/warehouse_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/domain/usecases/get_all_category_usecase.dart';
import 'package:hazard/domain/usecases/get_all_movements_usecase.dart';
import 'package:hazard/domain/usecases/get_all_product_usecase.dart';
import 'package:hazard/domain/usecases/get_all_warehouse_usecase.dart';
import 'package:hazard/presentation/models/category_stock_chart_data.dart';
import 'package:hazard/presentation/models/movement_chart_data.dart';
import 'package:hazard/presentation/models/recent_movement_chart_data.dart';
import 'package:hazard/presentation/models/warehouse_chart_data.dart';

class DashboardProvider extends ChangeNotifier {
  final GetAllProducts _getAllProducts;
  final GetAllCategories _getAllCategories;
  final GetAllWarehouses _getAllWarehouses;
  final GetAllMovements _getAllMovements;

  DashboardProvider({
    required GetAllProducts getAllProducts,
    required GetAllCategories getAllCategories,
    required GetAllWarehouses getAllWarehouses,
    required GetAllMovements getAllMovements,
  }) : _getAllProducts = getAllProducts,
       _getAllCategories = getAllCategories,
       _getAllWarehouses = getAllWarehouses,
       _getAllMovements = getAllMovements;

  List<ProductEntity> _products = [];
  List<CategoryEntity> _categories = [];
  List<WarehouseEntity> _warehouses = [];
  List<MovementEntity> _movements = [];

  bool _isLoading = false;
  Object? _error;

  bool get isLoading => _isLoading;

  Object? get error => _error;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getAllProducts(),
        _getAllCategories(),
        _getAllWarehouses(),
        _getAllMovements(),
      ]);
      _products = results[0] as List<ProductEntity>;
      _categories = results[1] as List<CategoryEntity>;
      _warehouses = results[2] as List<WarehouseEntity>;
      _movements = results[3] as List<MovementEntity>;
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _categoryName(String categoryId, String noCategoryLabel) {
    for (final category in _categories) {
      if (category.id == categoryId) return category.name;
    }
    return noCategoryLabel;
  }

  bool _isWithinLast7Days(DateTime date) {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final cutoff = startOfToday.subtract(const Duration(days: 6));
    final day = DateTime(date.year, date.month, date.day);
    return !day.isBefore(cutoff) && !day.isAfter(startOfToday);
  }

  int get totalStock =>
      _products.fold<int>(0, (sum, product) => sum + product.amount);

  int get entriesLast7Days => _movements
      .where(
        (movement) =>
            movement.type == MovementType.entry &&
            _isWithinLast7Days(movement.movementDate),
      )
      .fold<int>(0, (sum, movement) => sum + movement.quantity);

  int get exitsLast7Days => _movements
      .where(
        (movement) =>
            movement.type == MovementType.exit &&
            _isWithinLast7Days(movement.movementDate),
      )
      .fold<int>(0, (sum, movement) => sum + movement.quantity);

  int get returnsCount =>
      _movements.where((movement) => movement.returned).length;

  List<MovementEntity> recentMovements({int limit = 6}) {
    final sorted = _movements.toList()
      ..sort((a, b) => b.movementDate.compareTo(a.movementDate));
    return sorted.take(limit).toList();
  }

  List<RecentMovementChartData> recentMovementsChartData({int limit = 6}) {
    final movements = recentMovements(limit: limit).reversed;

    return [
      for (final movement in movements)
        RecentMovementChartData(
          label: movement.product.name,
          signedQuantity: movement.type == MovementType.entry
              ? movement.quantity
              : -movement.quantity,
          isEntry: movement.type == MovementType.entry,
        ),
    ];
  }

  List<ProductEntity> productsForWarehouse(String warehouseId) {
    return _products
        .where((product) => product.warehouseId == warehouseId)
        .toList();
  }

  List<MovementEntity> movementsForWarehouse(String warehouseId, {int? limit}) {
    final filtered =
        _movements
            .where((movement) => movement.product.warehouseId == warehouseId)
            .toList()
          ..sort((a, b) => b.movementDate.compareTo(a.movementDate));
    return limit == null ? filtered : filtered.take(limit).toList();
  }

  List<CategoryStockChartData> categoryChartData(String noCategoryLabel) {
    final Map<String, int> totalByCategory = {};

    for (final product in _products) {
      totalByCategory[product.categoryId] =
          (totalByCategory[product.categoryId] ?? 0) + product.amount;
    }

    return totalByCategory.entries
        .map(
          (entry) => CategoryStockChartData(
            category: _categoryName(entry.key, noCategoryLabel),
            quantity: entry.value,
          ),
        )
        .toList();
  }

  List<WarehouseStockChartData> get warehouseChartData {
    return [
      for (final warehouse in _warehouses)
        WarehouseStockChartData(
          warehouse: warehouse.name,
          quantity: _products
              .where((product) => product.warehouseId == warehouse.id)
              .fold<int>(0, (sum, product) => sum + product.amount),
        ),
    ];
  }

  List<MovementChartData> weeklyChartData(List<String> weekdayLabels) {
    final now = DateTime.now();

    final result = <MovementChartData>[];

    for (int i = 6; i >= 0; i--) {
      final day = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));

      int entries = 0;
      int exits = 0;

      for (final movement in _movements) {
        final date = movement.movementDate;

        if (date.year == day.year &&
            date.month == day.month &&
            date.day == day.day) {
          if (movement.type == MovementType.entry) {
            entries += movement.quantity;
          } else {
            exits += movement.quantity;
          }
        }
      }

      result.add(
        MovementChartData(
          day: weekdayLabels[day.weekday - 1],
          entries: entries,
          exits: exits,
        ),
      );
    }

    return result;
  }
}
