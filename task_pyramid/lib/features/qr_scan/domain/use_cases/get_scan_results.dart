import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/QrCodeRepository.dart';

class GetScanResults extends UseCase<Unit, NoParams> {
  final QrCodeRepository repository;
  GetScanResults({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.getScanResults();
  }
}

