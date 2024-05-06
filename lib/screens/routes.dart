import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/screens/auth/sign_up.dart';
import 'package:tolovde_pay/screens/auth/login.dart';
import 'package:tolovde_pay/screens/local_auth/biometrics/touch_id_screen.dart';
import 'package:tolovde_pay/screens/local_auth/password/confirm_lock_screen.dart';
import 'package:tolovde_pay/screens/local_auth/password/lock_screen.dart';
import 'package:tolovde_pay/screens/local_auth/password/initial_lock_screen.dart';

import 'package:tolovde_pay/screens/no_internet/no_internet_screen.dart';
import 'package:tolovde_pay/screens/on_boarding/on_boarding_screen.dart';
import 'package:tolovde_pay/screens/payment/payment_screen.dart';
import 'package:tolovde_pay/screens/splash/splash_screen.dart';
import 'package:tolovde_pay/screens/tab/profile/user_update_screen.dart';
import 'package:tolovde_pay/screens/tab/tab_screen.dart';
import 'package:tolovde_pay/screens/transfer/transfer_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.loginScreen:
        return navigate(const LoginScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.register:
        return navigate(const SignUpScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.setPinRoute:
        return navigate(const InitialLockScreen());
      case RouteNames.confirmPinRoute:
        return navigate(
            ConfirmLockScreen(previousPin: settings.arguments as String));
      case RouteNames.entryPinRoute:
        return navigate(const LockScreen());
      case RouteNames.touchIdRoute:
        return navigate(const TouchIdScreen());
      case RouteNames.updateUserRoute:
        return navigate(
            UserUpdateScreen(userModel: settings.arguments as UserModel));

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return CupertinoPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String tabRoute = "/tab_route";
  static const String register = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String setPinRoute = "/setPinRoute";
  static const String confirmPinRoute = "/confirmPinRoute";
  static const String entryPinRoute = "/entryPinRoute";
  static const String touchIdRoute = "/touchIdRoute";
  static const String updateUserRoute = "/updateUserRoute";
}
