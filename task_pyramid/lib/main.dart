import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constant/constant.dart';
import 'features/auth/presentation/cubit/login_cubit.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/qr_scan/presentation/cubit/qr_code_cubit.dart';
import 'features/qr_scan/presentation/pages/scan_results_screen.dart';
import 'features/qr_scan/presentation/pages/scan_screen.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => sl<LoginCubit>(),
        ),
        BlocProvider<QrCodeCubit>(
          create: (BuildContext context) => sl<QrCodeCubit>(),
        ),
      ],
      child: MaterialApp(
        title: '4th Pyramid task',
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Color(0xffCA252B)),
          primarySwatch: Constant.buildMaterialColor(const Color(0xffCA252B)),
        ),
        home:    const QrCodeScreen(),
      ),
    );
  }
}