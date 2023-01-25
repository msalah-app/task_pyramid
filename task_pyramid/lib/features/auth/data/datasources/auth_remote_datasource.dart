import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({required LoginParams params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper helper;

  AuthRemoteDataSourceImpl({required this.helper});

  @override
  Future<LoginResponse> login({required LoginParams params}) async {
    try {
      final response = await helper.post(
        url: loginAPI,
        body: {
          "phone": params.phone!.trim(),
          "password": params.password!.trim(),
        },
      ) ;
      if (response['status'] as bool) {
        final user = LoginResponse.fromMap(response['data']);
        return user;
      } else {
        throw UnauthorizedException(message: "خطأ في  بيانات تسجيل الدخول");
      }
    } on UnauthorizedException catch (e) {
      throw AuthException(message: e.message);
    } catch (e) {
      if (e is DioError) {
        throw ServerException(message: e.message);
      }
      rethrow;
    }
  }
}
