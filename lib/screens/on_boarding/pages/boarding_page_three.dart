



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/images/app_images.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.onBoard3,
          width: 280.w,
          height: 230.h,
        ),
        20.verticalSpace,
        Text(
          textAlign: TextAlign.center,
          "Your Comprehensive Resource for Financial Success",
          style: AppTextStyle.interBold
              .copyWith(color: AppColors.blue1, fontSize: 22.sp),
        ),
        10.verticalSpace,
        Text(
          textAlign: TextAlign.center,
          "Choosing the Right Bank for Your Financial Goals",
          style: AppTextStyle.interLight.copyWith(
            color: AppColors.blue1,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        100.verticalSpace,
      ],
    );
  }
}
