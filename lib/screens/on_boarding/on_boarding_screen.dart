
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/data/local/storage_repository.dart';
import 'package:tolovde_pay/screens/on_boarding/pages/boarding_page_one.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

import 'pages/boarding_page_three.dart';
import 'pages/boarding_page_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue1,
        onPressed: () {
          if (activeIndex == 2) {
            StorageRepository.setBool(
              key: "is_new_user",
              value: true,
            ).then(
              (value) {
                Navigator.pushReplacementNamed(context, RouteNames.register);
              },
            );
          } else {
            activeIndex += 1;
            controller.animateToPage(
              activeIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          }
        },
        child: const Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteNames.register);
                },
                child: Text(
                  'Skip',
                  style: AppTextStyle.interMedium.copyWith(
                    color: AppColors.blue1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  activeIndex = index;
                  setState(() {});
                },
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BoardingPageOne(),
                  BoardingPageTwo(),
                  BoardingPageThree(),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                "${activeIndex + 1}/3",
                style: AppTextStyle.interMedium.copyWith(fontSize: 18.sp),
              ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
