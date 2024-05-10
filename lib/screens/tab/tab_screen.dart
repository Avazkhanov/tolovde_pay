import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_event.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_state.dart';
import 'package:tolovde_pay/blocs/transaction/transaction_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_event.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/tab/card/card_screen.dart';
import 'package:tolovde_pay/screens/tab/history/history_screen.dart';
import 'package:tolovde_pay/screens/tab/home/home_screen.dart';
import 'package:tolovde_pay/screens/tab/profile/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  void initState() {
    debugPrint("Tab initga kirdi");
    context.read<UserProfileBloc>().add(GetUserProfileByUuIdEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const CardScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: screens,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TransactionBloc>().add(SetInitialEvent());
          Navigator.pushNamed(context, RouteNames.transferRoute);
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.currency_exchange),
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Colors.black,
            currentIndex: state.index,
            onTap: (index) {
              context.read<BottomBloc>().add(ChangeIndexEvent(index: index));
            },
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.credit_card,
                ),
                icon: Icon(
                  Icons.credit_card,
                  color: Colors.grey,
                ),
                label: 'Card',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.history,
                ),
                icon: Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                label: 'History',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
