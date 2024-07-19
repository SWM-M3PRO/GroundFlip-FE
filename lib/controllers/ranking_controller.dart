import 'package:get/get.dart';

class RankingController extends GetxController {
  final RxInt selectedType = 0.obs;

  getSelectedType() {
    return selectedType.value;
  }

  updateSelectedType(int type) {
    selectedType.value = type;
  }
}
