import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/homepage/widgets/card1.dart';
import 'package:learning_app/view/homepage/widgets/card2.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [Icon(Icons.shopping_cart)],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
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
                        "Welcome, usernakme",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("sub titles")
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/checkout");
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 400,
              color: ColorConstants.green,
              child: Image.network(
                "https://images.pexels.com/photos/27044393/pexels-photo-27044393/free-photo-of-a-black-and-white-photo-of-a-man-walking-his-dog-on-the-beach.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                      Text(
                        "pskill effectively with AI-powered coding exercises",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: 200,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card1(),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 4),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/seeall");
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                    color: ColorConstants.button_color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Popular for android developers",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card2(),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/seeall");
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                        color: ColorConstants.button_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.button_color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Center(
                          child: Text(
                            "development",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "short and sweet courses",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card2(),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/seeall");
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                        color: ColorConstants.button_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
