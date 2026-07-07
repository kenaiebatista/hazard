import 'package:hazard/domain/repositories/user_repository.dart';

class LoginUsecase {
  final UserRepository repository;

  LoginUsecase(this.repository);

  Future<bool> call(String email, String password) async {
    final user = await repository.getByEmail(email);
    return user != null && user.password == password;
  }
}
