import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/friends_screen.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DivideScreen extends StatefulWidget {
  const DivideScreen({super.key});

  @override
  State<DivideScreen> createState() => _DivideScreenState();
}

class _DivideScreenState extends State<DivideScreen> {
  int _selectedIndex = 1;
  // المؤشر الحالي للعنصر المحدد

  static List<Widget> _widgetOptions = <Widget>[
    const FriendsScreen(),
    GroupPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [
            Icons.person,
            Icons.group,
          ],

          activeIndex: _selectedIndex,
          gapLocation: GapLocation.center, // Optional: Adjust gap position
          notchSmoothness:
              NotchSmoothness.softEdge, // Optional: Customize notch smoothness
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.blue[900],

          inactiveColor: Colors.white, // Optional: Set color for inactive items
        ));
  }
}
