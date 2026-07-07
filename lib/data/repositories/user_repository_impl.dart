import 'package:hazard/domain/entities/user_entity.dart';
import 'package:hazard/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final List<UserEntity> _users = [
    UserEntity(name: 'Admin', email: 'admin@admin', password: '123456'),
  ];

  @override
  Future<void> save(UserEntity user) async {
    _users.add(user);
  }

  @override
  Future<UserEntity?> getByEmail(String email) async {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (_) {
      return null;
    }
  }
}
