import 'package:flutter/material.dart';
import 'package:learning_app/view/account_page/account_page.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/homepage/detail_page.dart';
import 'package:learning_app/view/homepage/homepage.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/login_page/login_page.dart';
import 'package:learning_app/view/my_learning/my_learning.dart';
import 'package:learning_app/view/register_page/register_page.dart';
import 'package:learning_app/view/search_screen/search_screen.dart';
import 'package:learning_app/view/slpash_screen/splash_screen.dart';
import 'package:learning_app/view/wishlist_page/wishlist_page.dart';

void main() {
  runApp(LearningApp());
}

class LearningApp extends StatefulWidget {
  const LearningApp({super.key});

  @override
  State<LearningApp> createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/bottomnavigation': (context) => const BottomNavigation(
              initialIndex: 0,
            ),
        '/home': (context) => const Homepage(),
        '/wishlist': (context) => const WishlistPage(),
        '/mylearning': (context) => const MyLearning(),
        '/account': (context) => const AccountPage(),
        '/search': (context) => const SearchScreen(),
        '/seeall': (context) => const SeeAllPage(),
        '/detailpage': (context) => const DetailPage(),
        '/recommentions': (context) => const RecommentionsCard(),
      },
    );
  }
}
