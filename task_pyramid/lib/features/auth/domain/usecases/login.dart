import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository repository;
  Login({required this.repository});
  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await repository.login(params: params);
  }
}

class LoginParams {
  String? phone;
  String? password;
  LoginParams({
    this.phone,
    this.password,
  });

}
