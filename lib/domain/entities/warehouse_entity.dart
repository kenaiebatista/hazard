import 'package:hazard/domain/entities/entity.dart';

class WarehouseEntity extends Entity{
  final String name;
  final String cep;
  final String street;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;
  final int capacity;

  WarehouseEntity({
    super.id,
    required this.name,
    required this.cep,
    required this.street,
    this.number = '',
    this.complement = '',
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.capacity,
  });

  String get address {
    final numberPart = number.isNotEmpty ? ', $number' : '';
    final complementPart = complement.isNotEmpty ? ' - $complement' : '';
    return '$street$numberPart$complementPart - $neighborhood, $city/$state - CEP: $cep';
  }
}