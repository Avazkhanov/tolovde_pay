import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_bloc.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_event.dart';
import 'package:tolovde_pay/blocs/bottom/bottom_state.dart';
import 'package:tolovde_pay/blocs/transaction/transaction_bloc.dart';
import 'package:tolovde_pay/screens/tab/card/card_screen.dart';
import 'package:tolovde_pay/screens/tab/home/home_screen.dart';
import 'package:tolovde_pay/screens/tab/profile/profile_screen.dart';
import 'package:tolovde_pay/screens/tab/transfer/transfer_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [];

  @override
  void initState() {
    context.read<TransactionBloc>().add(SetInitialEvent());
    screens = [
      const HomeScreen(),
      const TransferScreen(),
      const CardScreen(),
      const ProfileSettingsScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return  BottomNavigationBar(
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
                  Icons.currency_exchange_outlined,
                ),
                icon: Icon(
                  Icons.currency_exchange_outlined,
                  color: Colors.grey,
                ),
                label: 'Transfer',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.credit_card,
                ),
                icon: Icon(
                  Icons.credit_card,
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
