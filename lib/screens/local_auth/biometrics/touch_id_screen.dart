import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/data/local/storage_repository.dart';
import 'package:tolovde_pay/screens/dialogs/unical_dialog.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/widgets/button_container.dart';
import 'package:tolovde_pay/services/biometric_auth_service.dart';


class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200.h),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint,
                size: 150.sp,
                color: Colors.blue,
              ),
              Icon(
                CupertinoIcons.eye_fill,
                size: 150.sp,
                color: Colors.blue,
              ),
            ],
          ),
          const Spacer(),
          ButtonContainer(
            onTap: checkBiometrics,
            title: "Biometrics Auth",
          ),
          ButtonContainer(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            },
            title: "Skip",
          ),
        ],
      ),
    );
  }

  Future<void> checkBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(
        key: "biometrics_enabled",
        value: true,
      );
      if (!context.mounted) return;
      showUnicalDialog(errorMessage: "Biometrics enabled");
    } else {
      showUnicalDialog(errorMessage: "Biometrics disabled");
    }
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.tabRoute,
      (route) => false,
    );
  }
}
