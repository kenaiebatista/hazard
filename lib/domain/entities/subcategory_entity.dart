import 'package:hazard/domain/entities/entity.dart';
import 'package:hazard/domain/entities/product_entity.dart';

class SubcategoryEntity extends Entity {
  final String name;
  final List<ProductEntity> products;

  SubcategoryEntity({
    super.id,
    this.products = const [],
    required this.name
  });
}
