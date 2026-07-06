import 'package:hazard/domain/entities/entity.dart';
import 'package:hazard/domain/entities/subcategory_entity.dart';

class CategoryEntity extends Entity{
  final String name;
  final List<SubcategoryEntity> subcategories;

  CategoryEntity({
    super.id,
    required this.name,
    this.subcategories = const [],
   });
  }

