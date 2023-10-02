import 'package:flutter/material.dart';
import '../screens/authenticated/account.dart';
import '../screens/authenticated/preferences.dart';
import '../screens/authenticated/recommendations.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  static const List<Widget> _screenOptions = <Widget>[
    Recommendations(),
    Preferences(),
    Account(),
  ];

  void _onOptionTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screenOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Recommendations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Preferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onOptionTap,
      ),
    );
  }
}