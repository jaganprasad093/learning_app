import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/category_controller/category_controller.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/login&registration/changepsd_controler.dart';
import 'package:learning_app/controller/edit_controller.dart';
import 'package:learning_app/controller/login&registration/forgot_password_controller.dart';
import 'package:learning_app/controller/notification_controller/notificationsScreenController.dart';
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/controller/login&registration/register_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/view/account_page/account_page.dart';
import 'package:learning_app/view/account_page/edit_profile/edit_profile.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/checkout_page/checkout_page.dart';
import 'package:learning_app/view/checkout_page/confrim_animated.dart/confrim_animated.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/homepage.dart';
import 'package:learning_app/view/category_page/seeAllCatergories.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/account_page/change_pasd/change_password.dart';
import 'package:learning_app/view/login_page/forgot_password/forgot_psd2.dart';
import 'package:learning_app/view/login_page/login_page.dart';
import 'package:learning_app/view/my_learning/my_learning.dart';
import 'package:learning_app/view/login_page/forgot_password/forgot_password.dart';
import 'package:learning_app/view/notification_screen/notificationScreen.dart';
import 'package:learning_app/view/register_page/register_page.dart';
import 'package:learning_app/view/register_page/widgets/otp_verification.dart';
import 'package:learning_app/view/search_screen/search_screen.dart';
import 'package:learning_app/view/slpash_screen/splash_screen.dart';
import 'package:learning_app/view/wishlist_page/wishlist_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationControlller().initNotification();

  await Firebase.initializeApp();
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
        ),
        ChangeNotifierProvider(
          create: (context) => ChangepsdControler(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomepageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => Wishlistcontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cartcontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => Notificationsscreencontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
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
          // '/seeall': (context) => const SeeAllPage(
          //       caption: "",
          //     ),
          // '/detailpage': (context) => const DetailPage(),
          '/recommentions': (context) => const RecommentionsCard(
                index: 0,
              ),
          '/editprofile': (context) => const EditProfile(),
          '/checkout': (context) => const CheckoutPage(),
          '/otp': (context) => ForgotPassword(),
          '/confrim': (context) => ConfrimAnimated(),
          '/verification': (context) => Verification(),
          '/changepsd': (context) => Changepassword(),
          '/forgotpsd': (context) => ForgotPsd2(),
          '/notification': (context) => Notificationscreen(),
          '/seeallcategories': (context) => Seeallcatergories(),
        },
      ),
    );
  }
}
