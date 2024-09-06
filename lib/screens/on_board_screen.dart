import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/onboard_controller.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 1.0, keepPage: true);
    final OnboardController onboardController = Get.put(OnboardController());

    final List<String> onBoardImages = [
      'assets/images/onboard_image02.png',
      'assets/images/onboard_image03.png',
      'assets/images/onboard_image04.png',
      'assets/images/onboard_image05.png',
      'assets/images/onboard_image06.png',
      'assets/images/onboard_image07.png',
      'assets/images/onboard_image08.png',
      'assets/images/onboard_image09.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.65,
                        child: PageView.builder(
                          controller: controller,
                          itemCount: onBoardImages.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox.expand(
                                  child: Image.asset(
                                    onBoardImages[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: onBoardImages.length,
                          effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            type: WormType.normal,
                            activeDotColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      onboardController.goToMain();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          '플레이 가이드 넘기기',
                          style: TextStyles.fx17w700cTextThird,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
