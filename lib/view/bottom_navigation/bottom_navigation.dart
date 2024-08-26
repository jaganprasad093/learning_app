import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/account_page/account_page.dart';
import 'package:learning_app/view/homepage/homepage.dart';
import 'package:learning_app/view/my_learning/my_learning.dart';
import 'package:learning_app/view/search_screen/search_screen.dart';
import 'package:learning_app/view/wishlist_page/wishlist_page.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, required this.initialIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  List screenlist = [
    Homepage(),
    SearchScreen(),
    MyLearning(),
    WishlistPage(),
    AccountPage()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenlist[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          fixedColor: ColorConstants.button_color,
          unselectedItemColor: ColorConstants.button_color.withOpacity(.5),
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.star),
                icon: Icon(Icons.star_border),
                label: "Home"),
            BottomNavigationBarItem(
              label: "Search",
              activeIcon: Icon(Icons.search_rounded),
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.play_circle_fill_rounded),
                icon: Icon(Icons.play_circle_outline_outlined),
                label: "My learning"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border),
                label: "Wishlist"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: "Account"),
          ]),
    );
  }
}
