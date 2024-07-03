import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ground_flip/utils/android_notification.dart';

import 'screens/main_screen.dart';
import 'utils/walking_service_factory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  runApp(const MyApp());
  // var test = WalkingServiceFactory.getWalkingService();
  // print(test.hashCode);
  // initForegroundTask();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var test = WalkingServiceFactory.getWalkingService();
    print('메인 생성${test.hashCode}');
    initForegroundTask();
    // initForegroundTask();
    return GetMaterialApp(
      title: 'Ground Flip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      getPages: [
        GetPage(name: '/main', page: () => const MainScreen()),
      ],
    );
  }
}
