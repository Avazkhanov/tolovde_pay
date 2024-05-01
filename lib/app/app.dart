import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/data/repositories/auth_repository.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/services/local_notification_service.dart';

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
        ],
        child: ScreenUtilInit(
          designSize: const Size(430, 930),
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              theme: ThemeData(
                  useMaterial3: false
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              navigatorKey: navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}