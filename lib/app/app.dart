import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_bloc.dart';
import 'package:tolovde_pay/data/repositories/auth_repository.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/services/local_notification_service.dart';
import 'package:tolovde_pay/utils/app_theme/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => AuthRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => BottomBloc()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(430, 930),
          builder: (context, child) {
            ScreenUtil.init(context);
            return AdaptiveTheme(
              light: AppTheme.lightTheme,
              dark: AppTheme.darkTheme,
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  darkTheme: darkTheme,
                  initialRoute: RouteNames.splashScreen,
                  navigatorKey: navigatorKey,
                  onGenerateRoute: AppRoutes.generateRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}