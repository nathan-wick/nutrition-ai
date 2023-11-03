import 'package:flutter/material.dart';

import '../screens/authenticated/recommendations.dart';
import '../screens/authenticated/preferences.dart';
import '../screens/authenticated/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  static const pages = [
    RecommendationsScreen(),
    PreferencesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: currentIndex);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Recommendations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Preferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
      ),
    );
  }
}