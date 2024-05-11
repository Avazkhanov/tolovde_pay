import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/transaction/transaction_bloc.dart';
import 'package:tolovde_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:tolovde_pay/data/repositories/auth_repository.dart';
import 'package:tolovde_pay/data/repositories/cards_repository.dart';
import 'package:tolovde_pay/data/repositories/user_profile_repository.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/services/local_notification_service.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => UserProfileRepository(),
        ),
        RepositoryProvider(
          create: (_) => CardsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(CheckAuthenticationEvent()),
          ),
          BlocProvider(create: (_) => BottomBloc()),
          BlocProvider(
              create: (context) =>
                  UserProfileBloc(context.read<UserProfileRepository>())),
          BlocProvider(
            create: (context) => CardsBloc(
              cardsRepository: context.read<CardsRepository>(),
            )
              ..add(GetCardsDatabaseEvent())
              ..add(GetActiveCards()),
          ),
          BlocProvider(
            create: (context) => TransactionBloc(
              cardsRepository: context.read<CardsRepository>(),
            ),
          )
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              navigatorKey: navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          }
        )
      ),
    );
  }
}
