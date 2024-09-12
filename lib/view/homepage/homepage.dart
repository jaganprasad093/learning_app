import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<HomepageController>();
    return Scaffold(
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
                    height: 40,
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
                                child: Icon(Icons.shopping_cart_outlined)),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/notification");
                                },
                                child: Icon(
                                    Icons.notification_important_outlined)),
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
                                "From critical skills to technical topics, Udemy supports your professional development"),
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
    );
  }
}
