import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/connectivity/connectivity_bloc.dart';
import 'package:tolovde_pay/blocs/connectivity/connectivity_state.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';


class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key, required this.onInternetComeBack})
      : super(key: key);
  final VoidCallback onInternetComeBack;

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  // bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        debugPrint("ON POP INVOKED:$value");
      },
      child: Scaffold(

        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "NO INTERNET",
                  style: AppTextStyle.interSemiBold.copyWith(fontSize: 32),
                ),
              ),
            ),
            BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state.hasInternet) {
                  widget.onInternetComeBack.call();
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
