import 'package:hazard/domain/entities/address_entity.dart';
import 'package:hazard/domain/repositories/address_repository.dart';

class GetAddressByCepUsecase {
  final AddressRepository repository;

  GetAddressByCepUsecase(this.repository);

  Future<AddressEntity?> call(String cep) {
    return repository.getByCep(cep);
  }
}