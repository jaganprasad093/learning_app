import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/category_controller/category_controller.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/category_page/subCategories.dart';
import 'package:learning_app/view/category_page/widgets/category_card.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/detail_page/widgets/recent_seeall.dart';
import 'package:learning_app/view/homepage/widgets/recentlyViewed.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final int id;
  const CategoryScreen({
    super.key,
    required this.id,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    ini();
    super.initState();
  }

  ini() async {
    await context.read<CategoryController>().getCategoryItem(widget.id);
    await context.read<HomepageController>().getRecentlyViewed();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomepageController>();
    var getprovider = provider.recentlyViewedModel?.data?.data;
    var catProvider = context.watch<CategoryController>();
    var categoryProv = catProvider.categorymodel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courses to get you started",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: categoryProv?.message != "success"
          ? Center(child: Text("No data found !"))
          : catProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var data =
                                    catProvider.categorymodel?.data?[index];
                                var course_name = data?.courseName;
                                var rating = data?.rating;
                                // var offerPrice = data?.offerPrice;
                                var price = data?.price;
                                var photo = data?.thumbnail?.fullSize;
                                log("data----$data");
                                return CategoryCard(
                                  course_name: course_name ?? "",
                                  // offerPrice: 750,
                                  price: price ?? 0,
                                  rating: rating ?? 0,
                                  photo: photo ?? "",
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 20,
                                  ),
                              itemCount: context
                                      .read<CategoryController>()
                                      .categorymodel
                                      ?.data
                                      ?.length ??
                                  0),
                        ),
                        Text(
                          "Subcategories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Subcategories(
                                                id: catProvider
                                                        .subCategoryList[index]
                                                    ["id"]),
                                          ));
                                    },
                                    child: Container(
                                      // width: 150,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.button_color,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.all(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          "${catProvider.subCategoryList[index]["sub_category_name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  ColorConstants.button_color,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 2),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        getprovider?.length == 0
                            ? SizedBox()
                            : Column(
                                children: [
                                  Text(
                                    "Recently viewed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 200,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            // physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                                    onTap: () {
                                                      var id = context
                                                              .read<
                                                                  HomepageController>()
                                                              .recentlyViewedModel
                                                              ?.data
                                                              ?.data?[index]
                                                              .id ??
                                                          0;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    DetailPage(
                                                                        id: id),
                                                          ));
                                                    },
                                                    child: SearchCard(
                                                        index: index)),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: 10,
                                            ),
                                            itemCount:
                                                (getprovider?.length ?? 0) < 3
                                                    ? (getprovider?.length ?? 0)
                                                    : 3,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecentSeaAll(
                                                        caption:
                                                            "Recently viewed",
                                                        value: "recently",
                                                      ),
                                                    ));
                                              },
                                              child: (getprovider?.length) == 4
                                                  ? Text(
                                                      "See all  ",
                                                      style: TextStyle(
                                                          color: ColorConstants
                                                              .button_color,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    )
                                                  : SizedBox(),
                                            ),
                                            SizedBox(
                                              height: 90,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        Text(
                          "Recommentions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var id =
                                  provider.recommendedModel?.data?[index].id;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(id: id ?? 0),
                                      ));
                                  context
                                      .read<HomepageController>()
                                      .getCourseDetails(id);
                                },
                                child: RecommentionsCard(
                                  index: index,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                provider.recommendedModel?.data?.length ?? 0),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
