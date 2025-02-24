import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/notification_controller/notificationsScreenController.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('islogged') ?? false;
      if (isLoggedIn) {
        Navigator.pushNamed(context, "/bottomnavigation");
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
    var provider = context.read<HomepageController>();
    provider.getRecommendedCourses();
    context.read<Notificationsscreencontroller>().getNotifications();
    provider.getBanners();
    provider.getTopCourses();
    provider.getFeaturedCourse();
    provider.getCategoryList();

    context.read<Wishlistcontroller>().getWishlist();
    context.read<Cartcontroller>().getCart();
    // context.read<Cartcontroller>().AddCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Image.asset(
          ImageConstants.splashscreen,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
