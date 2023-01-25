part of 'qr_code_cubit.dart';

abstract class ScanResultsState extends Equatable {
  const ScanResultsState();

  @override
  List<Object> get props => [];
}

class ScanResultsInitial extends ScanResultsState {}

class ScanResultsLoading extends ScanResultsState {}

class ScanResultsLoadingMore extends ScanResultsState {}

class ScanResultsHasData extends ScanResultsState {}

class ScanResultsError extends ScanResultsState {}
