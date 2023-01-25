import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/login_response_model.dart';
import '../error/exceptions.dart';

const userCacheConst = "user_cache";
const cacheTokenConst = "cache_token";
const loginInfoConst = "login_info";

abstract class AuthLocalDataSource {
  Future<void> cacheUserAcssesToken({required String token});
  Future<LoginResponseModel> getCacheUserAcssesToken();
  Future<void> clearData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreference;

  AuthLocalDataSourceImpl({required this.sharedPreference});

  @override
  Future<void> cacheUserAcssesToken({required String token}) async {
    try {
      await sharedPreference.setString(cacheTokenConst, token);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<LoginResponseModel> getCacheUserAcssesToken() async {
    try {
      final usershared = sharedPreference.getString(cacheTokenConst);
      if (usershared != null) {
        final json = jsonDecode(usershared);
        return LoginResponseModel.fromMap(json);
      } else {
        throw NoCachedUserException();
      }
    } on NoCachedUserException {
      throw NoCachedUserException();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearData() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      throw NoCachedUserException();
    }
  }
}
