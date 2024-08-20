import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ground_flip/utils/secure_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

import 'controllers/main_controller.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/on_board_screen.dart';
import 'screens/permission_request_screen.dart';
import 'screens/policy_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/sign_up_screen.dart';
import 'service/auth_service.dart';
import 'service/location_service.dart';
import 'utils/user_manager.dart';
import 'utils/version_check.dart';
import 'widgets/common/internet_disconnect.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final SecureStorage secureStorage = SecureStorage();
  await secureStorage.secureStorage.write(key: "currentSteps", value: '0');

  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('######Got a message whilst in the foreground!#####');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  KakaoSdk.init(nativeAppKey: dotenv.env['NATIVE_APP_KEY']!);

  LocationService().initBackgroundLocation();

  String initialRoute = await AuthService().isLogin() ? '/main' : '/permission';

  VersionCheck versionCheck = VersionCheck();
  versionCheck.versionCheck();

  runApp(
    MyApp(
      initialRoute: initialRoute,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});

  final String initialRoute;
  static bool checkInternet = true;

  final listener =
      InternetConnection().onStatusChange.listen((InternetStatus status) {
    final MainController mainController = Get.find<MainController>();
    switch (status) {
      case InternetStatus.connected:
        mainController.internetCheck.value = true;
        if (mainController.isAlertIsShow.value) {
          Get.back();
          mainController.isAlertIsShow.value = false;
        }
        break;
      case InternetStatus.disconnected:
        mainController.internetCheck.value = false;
        Timer(
          Duration(seconds: 5),
          () {
            if (!mainController.internetCheck.value) {
              mainController.isAlertIsShow.value = true;
              Get.dialog(
                InternetDisconnect(),
              );
            }
          },
        );
        break;
    }
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logAppOpen();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        title: 'Ground Flip',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        getPages: [
          GetPage(
            name: '/main',
            page: () {
              analytics.setUserId(id: UserManager().userId.toString());
              return const MainScreen();
            },
          ),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/setting', page: () => SettingScreen()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(name: '/policy', page: () => const PolicyScreen()),
          GetPage(
            name: '/permission',
            page: () => const PermissionRequestScreen(),
          ),
          GetPage(name: '/onboard', page: () => const OnBoardScreen()),
        ],
      ),
    );
  }
}
