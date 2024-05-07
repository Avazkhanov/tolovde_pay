import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_event.dart';
import 'package:tolovde_pay/screens/dialogs/unical_dialog.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/widgets/text_field_container.dart';
import 'package:tolovde_pay/screens/widgets/rounded_button.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/images/app_images.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';
import 'package:tolovde_pay/utils/validates/app_validates.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log In",
                      style: AppTextStyle.interBold.copyWith(
                        color: AppColors.blue1,
                        fontSize: 32.sp,
                      ),
                    ),
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(LoginWithGoogle());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.googleIcon),
                            10.horizontalSpace,
                            Text(
                              "Google",
                              style: AppTextStyle.interLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: const Divider(),
                        ),
                        10.horizontalSpace,
                        Text("or",
                            style: TextStyle(
                                color: const Color(0xff486484),
                                fontSize: 18.sp)),
                        10.horizontalSpace,
                        SizedBox(
                          width: 100.w,
                          child: const Divider(),
                        ),
                      ],
                    ),
                    TextFieldContainer(
                      regExp: AppValidates.emailExp,
                      errorText: "Gmailni to'g'ri kiriting",
                      keyBoardType: TextInputType.text,
                      controller: emailController,
                      hintText: "Email",
                    ),
                    TextFieldContainer(
                      isObscureText: true,
                      regExp: AppValidates.passwordExp,
                      errorText: "Parolni to'g'ri kiriting",
                      keyBoardType: TextInputType.text,
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    20.verticalSpace,
                    Center(
                      child: SizedBox(
                        width: 200.w,
                        height: 46.h,
                        child: RoundedButton(
                          text: "Get Started Now",
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  LoginEvent(emailController.text,
                                      passwordController.text),
                                );
                          },
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    Text("Don't have an account?",
                        style: AppTextStyle.interSemiBold),
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.register);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Register",
                            style: AppTextStyle.interMedium
                                .copyWith(color: AppColors.secondaryColor),
                          ),
                          10.horizontalSpace,
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.secondaryColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state is AuthErrorState) {
              showUnicalDialog(errorMessage: state.errorText);
            }

            if (state is AuthSuccessState) {
              context.read<UserProfileBloc>().add(GetUserProfileByUuIdEvent());
              Navigator.pushReplacementNamed(context, RouteNames.setPinRoute);
            }
          },
          listenWhen: (last, current) {
            if (current is AuthErrorState || current is AuthSuccessState) {
              return true;
            }
            return false;
          },
          buildWhen: (last, current) {
            if (current is! AuthErrorState || current is! AuthSuccessState) {
              return true;
            }
            return false;
          },
        ),
      ),
    );
  }
}
