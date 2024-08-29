import 'package:flutter/material.dart';
import 'package:learning_app/controller/edit_controller.dart';
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/controller/register_controller.dart';
import 'package:learning_app/core/widgets/pop_up_screen.dart';
import 'package:learning_app/view/account_page/account_page.dart';
import 'package:learning_app/view/account_page/edit_profile/edit_profile.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/checkout_page/checkout_page.dart';
import 'package:learning_app/view/checkout_page/confrim_animated.dart/confrim_animated.dart';
import 'package:learning_app/view/homepage/detail_page.dart';
import 'package:learning_app/view/homepage/homepage.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/login_page/login_page.dart';
import 'package:learning_app/view/my_learning/my_learning.dart';
import 'package:learning_app/view/login_page/otp_submission/otp_submission.dart';
import 'package:learning_app/view/register_page/register_page.dart';
import 'package:learning_app/view/register_page/widgets/otp_verification.dart';
import 'package:learning_app/view/search_screen/search_screen.dart';
import 'package:learning_app/view/slpash_screen/splash_screen.dart';
import 'package:learning_app/view/wishlist_page/wishlist_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationControlller().initNotification();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationControlller(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditController(),
        )
      ],
      child: MaterialApp(
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
          '/editprofile': (context) => const EditProfile(),
          '/checkout': (context) => const CheckoutPage(),
          '/otp': (context) => OtpSubmission(),
          '/confrim': (context) => ConfrimAnimated(),
          '/verification': (context) => Verification(),
        },
      ),
    );
  }
}
