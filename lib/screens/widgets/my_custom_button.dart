import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';


import '../../utils/styles/app_text_style.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.onTap,
    this.readyToSubmit = true,
    this.isLoading = false,
    required this.title,
    this.color = AppColors.c_1317DD,
    this.subColor = Colors.grey,
    this.horizontalPad = 16,
    this.verticalPad = 16,
    this.titleColor = AppColors.white,
  });

  final VoidCallback onTap;
  final bool readyToSubmit;
  final bool isLoading;
  final String title;
  final Color color;
  final Color titleColor;
  final Color subColor;
  final int verticalPad;
  final int horizontalPad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPad.h,
        horizontal: horizontalPad.w,
      ),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            backgroundColor: readyToSubmit ? color : subColor,
          ),
          onPressed: readyToSubmit ? onTap : null,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 36.h,
                    width: 36.h,
                    child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 5),
                  )
                : Text(
                    title,
                    style: AppTextStyle.interSemiBold.copyWith(
                      fontSize: 24,
                      color: titleColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
