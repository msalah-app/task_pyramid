import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/use_cases/scan_qr_code.dart';


abstract class QrScanRemoteDataSource {
  Future<Unit> getScanResults();
  Future<Unit> scanQrCode({required ScanQrCodeParams params});
}

class QrScanRemoteDataSourceImpl implements QrScanRemoteDataSource {
  final ApiBaseHelper helper;
  QrScanRemoteDataSourceImpl({required this.helper});
  @override
  Future<Unit> getScanResults()async {
    try {
      final response =
          await helper.get(url: getScanCodeAPI);
      // return NewArrivalsResponse.fromMap(response);
      return response;
    } on DioError catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        throw ServerException(message: e.message);
      }
    }
  }

  @override
  Future<Unit> scanQrCode({required ScanQrCodeParams params})async {
    try {
      final response =
          await helper.post(url: scanApi,body:{
            "code" : params.code
          },
              );
      return response;
    } on DioError catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        throw ServerException(message: e.message);
      }
    }
  }}
