import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../use_cases/scan_qr_code.dart';

abstract class QrCodeRepository {
  Future<Either<Failure, Unit>> scanQrCode({required ScanQrCodeParams params});
  Future<Either<Failure, Unit>> getScanResults();
}
