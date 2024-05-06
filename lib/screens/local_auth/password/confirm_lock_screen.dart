import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinput/pinput.dart';
import 'package:tolovde_pay/data/local/storage_repository.dart';
import 'package:tolovde_pay/screens/local_auth/password/widgets/custom_keyboard_view.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/services/biometric_auth_service.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

import 'widgets/pin_put_view.dart';

class ConfirmLockScreen extends StatefulWidget {
  const ConfirmLockScreen({super.key, required this.previousPin});

  final String previousPin;

  @override
  State<ConfirmLockScreen> createState() => _ConfirmLockScreenState();
}

class _ConfirmLockScreenState extends State<ConfirmLockScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  bool biometricsEnabled = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticate().then((value) {
      if (value) {
        biometricsEnabled = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150.h),
          Text(
            "Pin kodni qayta kiriting!",
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
          Text(
            isError ? "Pin kod oldingisi bilan mos emas" : "",
            style: AppTextStyle.interMedium.copyWith(color: Colors.red),
          ),
          CustomKeyboardView(
            onFingerPrintTap: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                isError = false;
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (widget.previousPin == pinPutController.text) {
                  _setPin(pinPutController.text);
                } else {
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
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

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(
      key: "pin_code",
      value: pin,
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      biometricsEnabled ? RouteNames.touchIdRoute : RouteNames.tabRoute,
      (route) => false,
    );
  }
}
