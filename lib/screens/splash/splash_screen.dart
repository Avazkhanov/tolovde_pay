import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/images/app_images.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

import '../../../data/local/storage_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.register);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.entryPinRoute);
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.appLogo,
              width: 200.w,
              height: 200.h,
            ),
            // 15.verticalSpace,
            Text(
              "To'lovde pay",
              style: AppTextStyle.interBold.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 66.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor),
            ),
            Text(
              "The right relationship is everything.",
              style: AppTextStyle.interBold.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
