import 'package:flutter/material.dart';
import 'package:tolovde_pay/screens/auth/login_screen.dart';
import 'package:tolovde_pay/screens/auth/regsiter_screen.dart';
import 'package:tolovde_pay/screens/local_auth/biometric/touch_id_screen.dart';
import 'package:tolovde_pay/screens/local_auth/pin/confirm_pin_screen.dart';
import 'package:tolovde_pay/screens/local_auth/pin/entry_pin_screen.dart';
import 'package:tolovde_pay/screens/local_auth/pin/set_pin_screen.dart';
import 'package:tolovde_pay/screens/no_internet/no_internet_screen.dart';
import 'package:tolovde_pay/screens/on_boarding/on_boarding_screen.dart';
import 'package:tolovde_pay/screens/profile_edit/profile_edit_screen.dart';
import 'package:tolovde_pay/screens/security/security_screen.dart';
import 'package:tolovde_pay/screens/splash/splash_screen.dart';
import 'package:tolovde_pay/screens/tab/card/add_card_screen.dart';
import 'package:tolovde_pay/screens/tab/tab_screen.dart';
import 'package:tolovde_pay/screens/tab/transfer/transfer_screen.dart';

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
      case RouteNames.authRoute:
        return navigate(const AuthScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.registerRoute:
        return navigate(const RegisterScreen());
      case RouteNames.setPinRoute:
        return navigate(const SetPinScreen());
      case RouteNames.confirmPinRoute:
        return navigate(
            ConfirmPinScreen(previousPin: settings.arguments as String));
      case RouteNames.entryPinRoute:
        return navigate(const EntryPinScreen());
      case RouteNames.touchIdRoute:
        return navigate(const TouchIdScreen());
      case RouteNames.editProfileRoute:
        return navigate(const ProfileEditScreen());
      case RouteNames.securityRoute:
        return navigate(const SecurityScreen());
      case RouteNames.addCardRoute:
        return navigate(const AddCardScreen());
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
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String authRoute = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String registerRoute = "/register_route";
  static const String setPinRoute = "/setPinRoute";
  static const String confirmPinRoute = "/confirmPinRoute";
  static const String entryPinRoute = "/entryPinRoute";
  static const String touchIdRoute = "/touchIdRoute";
  static const String editProfileRoute = "/edit_profile_route";
  static const String securityRoute = "/security_route";
  static const String addCardRoute = "/add_card_route";
}
