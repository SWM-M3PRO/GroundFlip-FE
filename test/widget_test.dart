// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ground_flip/models/individual_history_pixel_info.dart';
import 'package:ground_flip/service/pixel_service.dart';
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  test('test', () async {
    final service = PixelService();
    IndividualHistoryPixelInfo pixel = await service.getIndividualHistoryPixelInfo(pixelId: 4049087, userId: 2);
    print(pixel.visitList);
  });
}
