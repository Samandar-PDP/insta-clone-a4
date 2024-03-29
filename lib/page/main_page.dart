import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_qlone/page/add_page.dart';
import 'package:insta_qlone/page/home_page.dart';
import 'package:insta_qlone/page/profile_page.dart';
import 'package:insta_qlone/page/reels_page.dart';
import 'package:insta_qlone/page/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final _screens = [
    HomePage(),
    SearchPage(),
    AddPage(),
    ReelsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (v) => setState(() { _selectedIndex = v; }),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white24,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: ''),
        ],
      ),
    );
  }
}
