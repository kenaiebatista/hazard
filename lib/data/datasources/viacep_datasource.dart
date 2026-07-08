import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hazard/core/errors/app_exception.dart';
import '../../domain/entities/address_entity.dart';

class ViaCepDataSource {
  Future<AddressEntity?> getByCep(String cep) async {
    final response = await http.get(
      Uri.parse('https://viacep.com.br/ws/$cep/json/'),
    );

    if (response.statusCode != 200) {
      throw const AppException(AppErrorKey.cepLookupFailed);
    }

    final json = jsonDecode(response.body);

    if (json['erro'] == true) {
      return null;
    }

    return AddressEntity(
      cep: json['cep'] ?? cep,
      street: json['logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
      city: json['localidade'] ?? '',
      state: json['uf'] ?? '',
    );
  }
}
