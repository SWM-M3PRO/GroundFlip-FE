import '../utils/walking_service.dart';

//ToDo : 안드로이드 서비스 실제로 구현하기
class AndroidWalkingService implements WalkingService {
  @override
  Future<int> getCurrentStep() {
    return Future.value(4251);
  }

  @override
  Future<List<int>> getDailyStepsInInterval(
    DateTime startDate,
    DateTime endDate,
  ) {
    return Future.value([1500, 2500, 3500, 4500, 5500, 6500, 7500]);
  }
}
