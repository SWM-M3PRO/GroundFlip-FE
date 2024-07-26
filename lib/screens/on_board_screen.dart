import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 1.0, keepPage: true);

    final List<Widget> onBoardImages = [
      SizedBox.expand(
        child: Image.asset(
          'assets/images/onboard_image01.png',
          fit: BoxFit.contain,
        ),
      ),
      SizedBox.expand(
        child: Image.asset(
          'assets/images/onboard_image02.png',
            fit: BoxFit.contain,
        ),
      ),
      SizedBox.expand(
        child: Image.asset(
          'assets/images/current_pixel_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.buttonColor,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    SizedBox(
                      height: 540,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: onBoardImages.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: onBoardImages[index],),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: onBoardImages.length,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          type: WormType.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
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
