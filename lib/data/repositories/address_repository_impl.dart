import 'package:hazard/data/datasources/viacep_datasource.dart';
import 'package:hazard/domain/entities/address_entity.dart';
import 'package:hazard/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ViaCepDataSource dataSource;

  AddressRepositoryImpl(this.dataSource);

  @override
  Future<AddressEntity?> getByCep(String cep) {
    return dataSource.getByCep(cep);
  }
}