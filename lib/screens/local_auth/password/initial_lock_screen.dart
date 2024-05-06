import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinput/pinput.dart';
import 'package:tolovde_pay/screens/local_auth/password/widgets/custom_keyboard_view.dart';
import 'package:tolovde_pay/screens/local_auth/password/widgets/pin_put_view.dart';

import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class InitialLockScreen extends StatefulWidget {
  const InitialLockScreen({super.key});

  @override
  State<InitialLockScreen> createState() => _InitialLockScreenState();
}

class _InitialLockScreenState extends State<InitialLockScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150.h),
          Text(
            "Pin Kodni o'rnating!",
            style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: 200.w,
            child: PinPutTextView(
              isError: isError,
              pinPutFocusNode: focusNode,
              pinPutController: pinPutController,
            ),
          ),
          SizedBox(height: 32.h),
          CustomKeyboardView(
            onFingerPrintTap: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                Navigator.pushNamed(
                  context,
                  RouteNames.confirmPinRoute,
                  arguments: pinPutController.text,
                );
                pinPutController.text = "";
              }
            },
            isBiometricsEnabled: false,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                  0,
                  pinPutController.text.length - 1,
                );
              }
            },
          )
        ],
      ),
    );
  }
}