

// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/pages/favorites/favorites_page.dart';
import 'package:travel_app/pages/home/home_page.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // app pages.
  final _pages = [
    // home.
    HomePage(),

    // favorites.
    FavoritesPage(),
  ];

  // selected page.
  int _selectedPage = 0;

  // navigation function.
  void _navigate(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      bottomNavigationBar: CurvedNavigationBar(
        color: ColorsManager.darkBrown,
        backgroundColor: _selectedPage == 0 ? ColorsManager.white : Colors.grey.shade200,
        animationCurve: Curves.linearToEaseOut,
        index: _selectedPage, // display the current index page.
        onTap: _navigate, // onTap? navigate to the page.
        items: [
          // home.
          Icon(Icons.home_outlined, size: 30, color: Colors.white),

          // favorites.
          Icon(Icons.favorite_border, size: 30, color: Colors.white),
        ],
      ),
      body: _pages[_selectedPage],
    );
  }
}