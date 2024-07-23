import 'package:get/get.dart';

class PolicyController extends GetxController {
  RxInt allPolicyChecked = 0.obs;
  RxInt allSelect = 0.obs;
  RxList<int> checkPolicy = [0, 0, 0].obs;

  void changeValue(int valueNum) {
    if (checkPolicy[valueNum] == 0) {
      checkPolicy[valueNum] = 1;
    } else {
      checkPolicy[valueNum] = 0;
    }
  }

  bool checkAllChecked() {
    int sum = 0;
    for (var i in checkPolicy) {
      sum += i;
    }
    if (sum == 3) {
      allPolicyChecked.value = 1;
      return true;
    } else {
      allPolicyChecked.value = 0;
      return false;
    }
  }

  void allPolicyCheck() {
    if(allPolicyChecked.value == 0){
      allPolicyChecked.value = 1;
      for (int i = 0; i < 3; i++) {
        checkPolicy[i] = 1;
      }
    }else{
      allPolicyChecked.value = 0;
      for (int i = 0; i < 3; i++) {
        checkPolicy[i] = 0;
      }
    }
  }
}
