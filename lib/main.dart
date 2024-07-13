import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/sign_up_screen.dart';
import 'service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  KakaoSdk.init(
    nativeAppKey: dotenv.env['NATIVE_APP_KEY']!,
  );

  String initialRoute = await AuthService().isLogin() ? '/main' : '/login';
  runApp(
    MyApp(
      initialRoute: initialRoute,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ground Flip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/setting', page: () => const SettingScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
      ],
    );
  }
}
