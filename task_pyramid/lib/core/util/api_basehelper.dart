import 'dart:io';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import 'package:dio/dio.dart';

const getScanCodeAPI = "my-codes";
const loginAPI = "login-scanner";
const scanApi = "scan";


class ApiBaseHelper {
  final String _baseUrl = "https://fourthpyramidagcy.net/company/api/v1/";
  final Dio dio = Dio();
  void dioInit() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers = headers;
    dio.options.sendTimeout = 15000; // time in ms
    dio.options.connectTimeout = 15000; // time in ms
  }

  ApiBaseHelper();
  Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": 'application/json'
  };

  Future<dynamic> get({required String url, String? token}) async {
    try {
      // headers["Content-language"] = local;
      // if (token != null) {
      //   headers["Authorization"] = "Bearer " + token;
      //   dio.options.headers = headers;
      // }
      final Response response = await dio.get(url);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      throw ServerException(message: e.message);
    } on SocketException {
      throw ServerException(message: "No Internet connections, try agin later");
    }
  }

  Future<dynamic> put({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      // headers["Content-language"] = local;
      final Response response;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      }
      if (body != null) {
        FormData formData = FormData.fromMap(body);
        response = await dio.put(url, data: formData);
      } else {
        response = await dio.put(url);
      }
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      throw ServerException(message: e.message);
    } on SocketException {
      throw ServerException(message: "No Internet connections, try agin later");
    }
  }

  Future<dynamic> post(
      {required String url,
      required Map<String, dynamic> body,
      String? token}) async {
    try {
      // headers["Content-language"] = local;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      }
      FormData formData = FormData.fromMap(body);
      final Response response = await dio.post(url, data: formData);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      throw _returenErrorMessage(
          e.response != null ? e.response!.statusCode! : 500);
    } on SocketException {
      throw ServerException(message: "No Internet connections, try agin later");
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 422:
        throw response.data.toString();
      case 401:
      case 403:
        throw DioError(
            requestOptions: response.requestOptions,
            error: "خطأ في بيانات تسجيل الدخول");
      case 500:
      default:
        debugPrint(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
        throw DioError(
            requestOptions: response.requestOptions,
            error: "نحن نواجة بعض المشاكل. يرجي لمحاولة لاحقا");
    }
  }
}

dynamic _returenErrorMessage(int statusCode) {
  switch (statusCode) {
    case 400:
    case 422:
      throw BadRequestException("نحن نواجة بعض المشاكل. يرجي لمحاولة لاحقا");
    case 401:
    case 403:
      throw ServerException(message: "خطأ في بيانات تسجيل الدخول");
    case 500:
    default:
      throw ServerException(
          message: "نحن نواجة بعض المشاكل. يرجي لمحاولة لاحقا");
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
