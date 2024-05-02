import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogOutEvent());
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Use dark theme",
                style: Theme.of(context).textTheme.titleLarge),
            trailing: CupertinoSwitch(
                value: darkTheme,
                onChanged: (v) {
                  setState(() {
                    darkTheme = v;
                  });
                  if (darkTheme) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                }),
          )
        ],
      ),
    );
  }
}
