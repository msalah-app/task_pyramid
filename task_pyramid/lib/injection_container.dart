import 'package:get_it/get_it.dart';
import 'package:task_pyramid/features/qr_scan/data/data_sources/qr_scan_remote_datasoure.dart';
import 'package:task_pyramid/features/qr_scan/data/repositories/qr_code_repository_impl.dart';
import 'package:task_pyramid/features/qr_scan/domain/repositories/QrCodeRepository.dart';
import 'package:task_pyramid/features/qr_scan/domain/use_cases/get_scan_results.dart';
import 'package:task_pyramid/features/qr_scan/domain/use_cases/scan_qr_code.dart';
import 'features/auth/presentation/cubit/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/local/auth_local_datasource.dart';
import 'core/util/api_basehelper.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/qr_scan/presentation/cubit/qr_code_cubit.dart';

final sl = GetIt.instance;
late final SharedPreferences sharedPreferences;
final helper = ApiBaseHelper();
Future<void> init() async {
  //! External
  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  helper.dioInit();
  sl.registerLazySingleton(() => helper);
  loginInj();
  scanResultsInj();
  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void loginInj() {
  //* provider
  sl.registerFactory(() => LoginCubit(login: sl()),);

  //* Use cases
  // sl.registerLazySingleton(() => ToggleUserBlockState(repository: sl()));
  // sl.registerLazySingleton(() => RegisterUserInformation(repository: sl()));
  sl.registerLazySingleton(() => Login(repository: sl()));

  //* Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remote: sl(),
      local: sl()),);

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      helper: sl(),),);
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreference: sl(),
    ),
  );
}

void scanResultsInj() {
  //* provider
  sl.registerFactory(
    () => QrCodeCubit(getScanResults: sl(), scanQrCode: sl()),
  );

  //* Use cases
  // sl.registerLazySingleton(() => ToggleUserBlockState(repository: sl()));
  // sl.registerLazySingleton(() => RegisterUserInformation(repository: sl()));
  sl.registerLazySingleton(() => GetScanResults(repository: sl()));
  sl.registerLazySingleton(() => ScanQrCode(repository: sl()));


  //* Repository
  sl.registerLazySingleton<QrCodeRepository>(
      () => QrCodeRepositoryImpl(remote: sl()));

  //* Data sources
  sl.registerLazySingleton<QrScanRemoteDataSource>(
    () => QrScanRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
}
