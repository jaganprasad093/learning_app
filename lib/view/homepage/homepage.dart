import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/notification_controller/notificationsScreenController.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/image_slider.dart';
import 'package:learning_app/view/homepage/homepage_widgets.dart/categoriesList.dart';
import 'package:learning_app/view/homepage/homepage_widgets.dart/featuredCourse.dart';
import 'package:learning_app/view/homepage/homepage_widgets.dart/recommented.dart';
import 'package:learning_app/view/homepage/homepage_widgets.dart/topCourses.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isread = false;
  var name;
  var email;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    email = prefs.getString("email") ?? "";
    context.read<Cartcontroller>().getCart();
    await context.read<Wishlistcontroller>().getWishlist();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // log("isread---$isread");
    var provider = context.watch<HomepageController>();
    var cartProvider = context.watch<Cartcontroller>();
    var notificationProvider = context.watch<Notificationsscreencontroller>();
    // log("length ---${cartProvider.cartModel?.data?.cartItem?.length}");

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [Icon(Icons.shopping_cart)],
        // ),
        body: provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome, $name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              // Text("sub titles")
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/checkout");
                                  },
                                  child: Stack(children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 28,
                                    ),
                                    cartProvider.cartModel?.data?.cartItem
                                                    ?.length ==
                                                0 ||
                                            cartProvider.cartModel?.data
                                                    ?.cartItem?.length ==
                                                null
                                        ? SizedBox()
                                        : Positioned(
                                            right: 0,
                                            top: 0,
                                            child: CircleAvatar(
                                              child: Center(
                                                child: Text(
                                                  "${cartProvider.cartModel?.data?.cartItem?.length}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: ColorConstants
                                                          .primary_white),
                                                ),
                                              ),
                                              radius: 7,
                                              backgroundColor: Colors.red,
                                            ))
                                  ])),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      isread = true;
                                    });
                                    Navigator.pushNamed(
                                        context, "/notification");
                                  },
                                  child: Stack(
                                    children: [
                                      Icon(Icons
                                          .notification_important_outlined),
                                      isread
                                          ? SizedBox()
                                          : notificationProvider
                                                          .notificationModel
                                                          ?.data
                                                          ?.length ==
                                                      0 &&
                                                  notificationProvider
                                                          .notificationModel
                                                          ?.data
                                                          ?.length ==
                                                      null
                                              ? SizedBox()
                                              : Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: CircleAvatar(
                                                    child: Center(
                                                      child: Text(
                                                        "${notificationProvider.notificationModel?.data?.length}",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: ColorConstants
                                                                .primary_white),
                                                      ),
                                                    ),
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ))
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ImageSlider(
                            imageUrls:
                                context.read<HomepageController>().bannerImg ??
                                    [],
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Skills for everyone & everything",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                  "From critical skills to technical topics, e-learning supports your professional development"),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Recommented(),
                          SizedBox(
                            height: 30,
                          ),
                          Topcourses(),
                          SizedBox(
                            height: 30,
                          ),
                          Categorieslist(),
                          SizedBox(
                            height: 30,
                          ),
                          Featuredcourse()
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
