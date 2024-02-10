import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/home.dart';
import 'package:project02_hackloop/screens/user.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  int _selectedIndex = 0;

  static List<Widget> _pages = [
    HomeScreen(),
    Icon(
      Icons.dashboard_customize,
      size: 150,
    ),
    Icon(
      Icons.qr_code_2_rounded,
      size: 150,
    ),
    usercenter()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: toColor("540000"),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: GNav(
          gap: 8,
          tabs:[
            GButton(
              icon: Icons.fastfood,
              text: 'meals.',
            ),
            GButton(
              icon: Icons.dashboard_rounded,
              text: 'Dashboard',
            ),
            GButton(
              icon: Icons.qr_code_2_outlined,
              text: 'QR',
            ),
            GButton(
              icon: Icons.settings,
              text: 'User Settings',
            ),
          ],
          backgroundColor: toColor("540000"),
          color: toColor("806060"),
          activeColor: toColor("d4d4d4"),
          padding: EdgeInsets.all(16),
          tabBackgroundGradient: LinearGradient(colors: [toColor("640000"),toColor("820000")]),
          haptic: true,
          onTabChange: _onItemTapped,
        ),
            ),
      )
    );
  }
}