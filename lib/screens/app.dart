import 'package:flutter/material.dart';
import 'package:skywander_app/screens/home/home.dart';
import 'package:skywander_app/screens/transactions/transaction.dart';
import 'package:skywander_app/screens/visa/visa.dart';
import 'package:skywander_app/screens/wishlist/wishlist.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentPageIndex = 0;
  final List<Widget> _screens = const <Widget>[
    HomeScreen(),
    VisaScreen(),
    WishlistScreen(),
    TransactionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildNavigationBar(),
      body: _getCurrentScreen(_currentPageIndex),
    );
  }

  Widget _buildNavigationBar() {
    return NavigationBar(
      selectedIndex: _currentPageIndex,
      onDestinationSelected: (index) => setState(() {
        _currentPageIndex = index;
      }),
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.airplane_ticket_outlined),
          selectedIcon: Icon(Icons.airplane_ticket),
          label: 'Visa',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance_wallet_outlined),
          selectedIcon: Icon(Icons.account_balance_wallet),
          label: 'Transactions',
        ),
      ],
    );
  }

  Widget _getCurrentScreen(int index) {
    return _screens[index];
  }
}
