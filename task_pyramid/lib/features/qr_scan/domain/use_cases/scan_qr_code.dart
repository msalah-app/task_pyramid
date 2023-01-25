import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/QrCodeRepository.dart';

class ScanQrCode extends UseCase<Unit, ScanQrCodeParams> {
  final QrCodeRepository repository;
  ScanQrCode({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(ScanQrCodeParams params) async {
    return await repository.scanQrCode(params: params);
  }
}

class ScanQrCodeParams {
  String? code;
  ScanQrCodeParams({
    this.code,
  });

}
