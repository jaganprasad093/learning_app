import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    context.read<Wishlistcontroller>().getWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Wishlistcontroller>();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(initialIndex: 0),
                  ));
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.wishlistList.isEmpty
              ? Center(child: Text("Wishlist is empty!"))
              : SingleChildScrollView(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = context
                            .watch<Wishlistcontroller>()
                            .wishlistList[index];
                        var auther_name = data.autherName;
                        var course_name = data.courseName;
                        var photo = data.courseImage;
                        var price = data.price;
                        var courseID = data.courseId;
                        var rating = data.rating;
                        // log("$photo");
                        log("length---${provider.wishlistList.length}");
                        return InkWell(
                          onTap: () {
                            var id = provider.wishlistList[index].courseId;
                            context
                                .read<HomepageController>()
                                .getCourseDetails(id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(id: id ?? 0),
                                ));
                          },
                          child: HorizontalCard(
                            rating: rating ?? 0,
                            courseID: courseID ?? 0,
                            isWishlist: true,
                            index: index,
                            description: "",
                            author_name: auther_name ?? "",
                            course_name: course_name ?? "",
                            photo: photo ?? "",
                            price: price ?? 0,
                            islearning: false,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: provider.wishlistList.length),
                ),
    );
  }
}
