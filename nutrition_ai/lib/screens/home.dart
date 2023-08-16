import 'package:flutter/material.dart';
import 'package:nutrition_ai/screens/account.dart';
import 'package:nutrition_ai/screens/preferences.dart';
import 'package:nutrition_ai/screens/recommendations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            label: 'recommendations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'preferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onOptionTap,
      ),
    );
  }
}
