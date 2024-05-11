import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:tolovde_pay/data/local/storage_repository.dart';
import 'package:tolovde_pay/data/models/forms_status.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/images/app_images.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasPin = false;

  _init(bool isAuthenticated) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (isAuthenticated == false) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    } else {
      Navigator.pushReplacementNamed(
          context, hasPin ? RouteNames.entryPinRoute : RouteNames.setPinRoute);
    }
  }

  @override
  void initState() {
    hasPin = StorageRepository.getString(key: "pin_code").isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == FormsStatus.authenticated) {
            BlocProvider.of<UserProfileBloc>(context).add(
                GetCurrentUserEvent(FirebaseAuth.instance.currentUser!.uid));

            _init(true);
          } else {
            _init(false);
          }
        },
        child: Center(
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
                    fontSize: 66.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.c_2A3256),
              ),
              Text(
                "The right relationship is everything.",
                style: AppTextStyle.interBold.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.c_2A3256),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
