import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
    const int lowBoundYear = 1900;
    const int upperBoundYear = 2024;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('프로필 입력'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.previousRoute;
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 80.0,
                  backgroundImage: controller.profileImage.value != null
                      ? FileImage(File(controller.profileImage.value!.path))
                          as ImageProvider
                      : AssetImage('assets/images/default_profile_image.png')
                          as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xffD9D9D9)),
                      ),
                      onPressed: controller.getImage,
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '닉네임',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '영어,한글,숫자 조합으로 3자 이상 10자 이내',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: Color(0xffD9D9D9),
                    child: TextField(
      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                      onChanged: controller.updateNickname,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '출생년도',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<int>(
                      value: controller.birthYear.value,
                      alignment: Alignment.center,
                      isExpanded: true,
                      onChanged: (birthYear) =>
                          controller.updateBirthYear(birthYear!),
                      items: List.generate(
                        upperBoundYear - lowBoundYear + 1,
                        (index) {
                          int year = 1900 + index;
                          return DropdownMenuItem(
                            value: year,
                            child: Text(
                              year.toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          );
                        },
                      ),
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '성별',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Obx(
                    () => ToggleButtons(
                      constraints: BoxConstraints.expand(
                          width:
                              (MediaQuery.of(context).size.width - 100) / 2,), //
                      isSelected: controller.toggleSelection,
                      onPressed: controller.updateSelectedGender,
                      children: [
                        Text(
                          '남성',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '여성',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isNicknameTyped.value
                      ? controller.completeRegistration
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: Text('완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
