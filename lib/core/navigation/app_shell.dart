import 'package:flutter/material.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/saving/presentation/saving_screen.dart';
import '../../features/transactions/presentation/transaction_log_screen.dart';
import '../../features/wishlist/presentation/wishlist_screen.dart';
import 'app_bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    HomeScreen(),
    TransactionLogScreen(),
    SavingScreen(),
    WishlistScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
