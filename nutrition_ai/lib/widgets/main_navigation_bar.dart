import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  final int defaultIndex;
  const MainNavigationBar({
    Key? key,
    this.defaultIndex = 0,
  }) : super(key: key);
  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  final screens = [
    (BuildContext context) => Navigator.popAndPushNamed(context, '/profile'),
    (BuildContext context) =>
        Navigator.popAndPushNamed(context, '/preferences'),
    (BuildContext context) =>
        Navigator.popAndPushNamed(context, '/recommendations'),
  ];
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          screens[index](context);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up),
          label: 'Preferences',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Recommendations',
        ),
      ],
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
