import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/screens/dialogs/unical_dialog.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/widgets/my_text_field.dart';
import 'package:tolovde_pay/screens/widgets/rounded_button.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/images/app_images.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';
import 'package:tolovde_pay/utils/validates/app_validates.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is AuthLoadState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
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
                    MyTextFieldWidget(
                      keyBoardType: TextInputType.text,
                      controller: nameController,
                      hintText: "Name",
                    ),
                    MyTextFieldWidget(
                      regExp: AppValidates.emailExp,
                      errorText: "Gmailni to'g'ri kiriting",
                      keyBoardType: TextInputType.text,
                      controller: emailController,
                      hintText: "Email",
                    ),
                    MyTextFieldWidget(
                      regExp: AppValidates.passwordExp,
                      errorText: "Parolni to'g'ri kiriting",
                      isObscureText: true,
                      keyBoardType: TextInputType.text,
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    MyTextFieldWidget(
                      regExp: AppValidates.passwordExp,
                      errorText: "Parolni to'g'ri kiriting",
                      isObscureText: true,
                      keyBoardType: TextInputType.text,
                      controller: confirmController,
                      hintText: "Confirm Password",
                    ),
                    20.verticalSpace,
                    Center(
                      child: SizedBox(
                        width: 200.w,
                        height: 46.h,
                        child: RoundedButton(
                          text: "Register",
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  RegisterEvent(
                                    UserModel(
                                      email: emailController.text,
                                      name: nameController.text,
                                      password: passwordController.text,
                                    ),
                                    confirmController.text,
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    Text("Already have an account?",
                        style: AppTextStyle.interSemiBold),
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.loginScreen);
                      },
                      child: Row(
                        children: [
                          Text(
                            "LOGIN",
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
              Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
            }
          },
          buildWhen: (last, current) {
            if (current is! AuthErrorState || current is! AuthSuccessState) {
              return true;
            }
            return false;
          },
          listenWhen: (last, current) {
            if (current is AuthErrorState || current is AuthSuccessState) {
              return true;
            }
            return false;
          },
        ),
      ),
    );
  }
}
