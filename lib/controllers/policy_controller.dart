import 'package:get/get.dart';

class PolicyController extends GetxController {
  late RxInt allPolicyChecked;
  late RxList<int> checkPolicyList;

  @override
  void onInit() async{
    super.onInit();
    await init();
  }

  Future<void> init() async{
    allPolicyChecked = 0.obs;
    checkPolicyList = [0, 0, 0, 0].obs;
  }

  void changeValue(int valueNum) {
    if (checkPolicyList[valueNum] == 0) {
      checkPolicyList[valueNum] = 1;
    } else {
      checkPolicyList[valueNum] = 0;
    }
  }

  bool checkAllChecked() {
    int sum = 0;
    for (var i in checkPolicyList) {
      sum += i;
    }
    if (sum == 4) {
      allPolicyChecked.value = 1;
      return true;
    } else {
      allPolicyChecked.value = 0;
      return false;
    }
  }

  void allPolicyCheck() {
    if (allPolicyChecked.value == 0) {
      allPolicyChecked.value = 1;
      for (int i = 0; i < 4; i++) {
        checkPolicyList[i] = 1;
      }
    } else {
      allPolicyChecked.value = 0;
      for (int i = 0; i < 4; i++) {
        checkPolicyList[i] = 0;
      }
    }
  }
}
