import 'package:hazard/domain/entities/entity.dart';

class UserEntity extends Entity {
  final String name;
  final String email;
  final String password;

  UserEntity({
    super.id,
    required this.name,
    required this.email,
    required this.password,
  });
}
