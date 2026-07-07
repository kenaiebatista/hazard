import 'package:hazard/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<AddressEntity?> getByCep(String cep);
}
