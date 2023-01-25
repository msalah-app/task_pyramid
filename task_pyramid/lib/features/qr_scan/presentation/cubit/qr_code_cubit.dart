import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pyramid/core/usecases/usecases.dart';
import 'package:task_pyramid/features/qr_scan/domain/use_cases/get_scan_results.dart';
import 'package:task_pyramid/features/qr_scan/domain/use_cases/scan_qr_code.dart';
part 'qr_code_state.dart';

class QrCodeCubit extends Cubit<ScanResultsState> {
  final GetScanResults getScanResults;
  final ScanQrCode scanQrCode;
  QrCodeCubit({required this.getScanResults ,required this.scanQrCode })
      : super(ScanResultsInitial());
  int nextPage = 1;
  bool isMore = false;
  List<String> scanResults = ["4877754","4877754","4877754"];
  Future<void> fGetScanResults() async {
    if (isGetScanResults()) {
      emitLoadingState(nextPage);
      final failOrResponse =
          await getScanResults(NoParams());
      failOrResponse.fold((fail) {
        emit(ScanResultsError());
      }, (newResponse) {
        // nextPage += 1;
        // isMore = newResponse.data.checkIfMore();
        // ScanResults += newResponse.data.ScanResults;
        emit(ScanResultsHasData());
      });
    }
  }
  Future<void> fScanQRCode(String code) async {
    final failOrResponse =
    await scanQrCode(ScanQrCodeParams(code:code ));
    failOrResponse.fold((fail) {
      emit(ScanResultsError());
    }, (newResponse) {
      // nextPage += 1;
      // isMore = newResponse.data.checkIfMore();
      // ScanResults += newResponse.data.ScanResults;
      emit(ScanResultsHasData());
    });
  }

    void emitLoadingState(int pageNumber) {
    pageNumber > 1
        ? emit(ScanResultsLoadingMore())
        : emit(ScanResultsLoading());
  }

  bool isGetScanResults() {
    return nextPage == 1 || isMore;
  }
}
