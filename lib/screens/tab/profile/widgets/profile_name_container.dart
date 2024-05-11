import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';


class ProfileNameContainer extends StatelessWidget {
  const ProfileNameContainer({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 12,
              blurRadius: 8,
              color: Colors.grey.shade200,
            )
          ]),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userModel.phoneNumber,
            style: AppTextStyle.interSemiBold.copyWith(
              fontSize: 18,
            ),
          ),
          Text(
            userModel.email,
            style: AppTextStyle.interSemiBold.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
