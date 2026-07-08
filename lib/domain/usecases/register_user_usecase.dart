import 'package:hazard/core/errors/app_exception.dart';
import 'package:hazard/domain/entities/user_entity.dart';
import 'package:hazard/domain/repositories/user_repository.dart';

class RegisterUserUsecase {
  final UserRepository repository;

  RegisterUserUsecase(this.repository);

  Future<void> call(UserEntity user) async {
    final existing = await repository.getByEmail(user.email);
    if (existing != null) {
      throw const AppException(AppErrorKey.emailAlreadyRegistered);
    }
    await repository.save(user);
  }
}
