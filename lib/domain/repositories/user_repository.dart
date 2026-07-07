import 'package:hazard/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> save(UserEntity user);

  Future<UserEntity?> getByEmail(String email);
}
