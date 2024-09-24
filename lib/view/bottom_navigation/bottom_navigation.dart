import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/account_page/account_page.dart';
import 'package:learning_app/view/homepage/homepage.dart';
import 'package:learning_app/view/my_learning/my_learning.dart';
import 'package:learning_app/view/search_screen/search_screen.dart';
import 'package:learning_app/view/wishlist_page/wishlist_page.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, required this.initialIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    init();
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  init() async {
    context.read<Cartcontroller>().getCart();
    await context.read<Wishlistcontroller>().getWishlist();

    setState(() {});
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
    var CartProvider = context.watch<Wishlistcontroller>();
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
                icon: Stack(children: [
                  Icon(
                    Icons.favorite_border,
                    size: 25,
                  ),
                  CartProvider.wishlistList.length == 0
                      ? SizedBox()
                      : Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 7,
                            child: Text(
                              "${CartProvider.wishlistList.length}",
                              style: TextStyle(
                                  color: ColorConstants.primary_white,
                                  fontSize: 8),
                            ),
                            backgroundColor: Colors.red,
                          ))
                ]),
                label: "Wishlist"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.account_circle),
                icon: Icon(Icons.account_circle_outlined),
                label: "Account"),
          ]),
    );
  }
}
