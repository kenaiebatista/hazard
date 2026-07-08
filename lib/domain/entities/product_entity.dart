import 'package:hazard/domain/entities/entity.dart';

class ProductEntity extends Entity{
  final String name;
  final String description;
  final String sku;
  final String categoryId;
  final String subcategoryId;
  final String warehouseId;
  final int amount;
  final String? imageUrl;

  ProductEntity({
    super.id,
    required this.name,
    required this.description,
    required this.sku,
    required this.categoryId,
    required this.subcategoryId,
    required this.warehouseId,
    this.amount = 0,
    this.imageUrl,
});
}
