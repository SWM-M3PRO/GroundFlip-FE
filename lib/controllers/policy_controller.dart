import 'package:get/get.dart';

class PolicyController extends GetxController {
  RxInt allPolicyChecked = 0.obs;
  RxList<int> checkPolicyList = [0, 0, 0].obs;

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
        checkPolicyList[i] = 1;
      }
    }else{
      allPolicyChecked.value = 0;
      for (int i = 0; i < 3; i++) {
        checkPolicyList[i] = 0;
      }
    }
  }
}
