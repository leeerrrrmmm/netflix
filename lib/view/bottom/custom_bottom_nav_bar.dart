import 'package:flutter/material.dart';
import 'package:netflix/view/comming_soon/comming_soon.dart';
import 'package:netflix/view/home/home_screen.dart';
import 'package:netflix/view/more/more_screen.dart';
import 'package:netflix/view/search/search.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _curPage = 0;
  final pages = [HomeScreen(), SearchScreen(), CommingSoon(), MoreScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        currentIndex: _curPage,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplay_sharp),
            label: 'Coming Soon',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
        onTap:
            (val) => setState(() {
              _curPage = val;
            }),
      ),
      body: pages[_curPage],
    );
  }
}
