import 'package:dartz/dartz.dart';
import 'package:task_pyramid/features/qr_scan/domain/use_cases/scan_qr_code.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../domain/repositories/QrCodeRepository.dart';
import '../data_sources/qr_scan_remote_datasoure.dart';

class QrCodeRepositoryImpl implements QrCodeRepository {
  final QrScanRemoteDataSource remote;

  QrCodeRepositoryImpl({ required this.remote});


  @override
  Future<Either<Failure, Unit>> scanQrCode({required ScanQrCodeParams params})async {
    try {
      final user = await remote.scanQrCode(params: params);
      // await local.cacheUserAcssesToken(token: user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> getScanResults() async{
    try {
      final user = await remote.getScanResults();
      // await local.cacheUserAcssesToken(token: user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? ''));
    }
  }
}
