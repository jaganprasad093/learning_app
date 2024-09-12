import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/view/detail_page/widgets/recent_seeall.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/homepage/widgets/recentlyViewed.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<HomepageController>().getRecentlyViewed();
    context.read<HomepageController>().getCourseDetails(widget.id);

    super.initState();
  }

  List varient = [
    'Beginner',
    'Intermediate',
    'Expert',
  ];
  String selectedValue = "Beginner";
  int TotalAmount = 0;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomepageController>();
    var data = provider.courseDetailModel?.data;
    var getprovider = provider.recentlyViewedModel?.data?.data;
    log("data-----$data");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/checkout");
              },
              child: Icon(Icons.shopping_cart_outlined)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        color: ColorConstants.button_color,
                        child: Image.network(
                          data?.first.thumbnail?.fullSize ?? "",
                          fit: BoxFit.cover,
                        ),
                        height: 200,
                        width: 350,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data?.first.courseName ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.all(2),
                          decoration: BoxDecoration(
                            color: ColorConstants.button_color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 10),
                            height: 25,
                            decoration: BoxDecoration(
                              color: ColorConstants.primary_white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButton<String>(
                              // isExpanded: true,
                              style: TextStyle(
                                color: ColorConstants.button_color,
                                fontWeight: FontWeight.bold,
                              ),
                              value: selectedValue,
                              onChanged: (newValue) {
                                TotalAmount = data?.first.price.toInt();

                                if (newValue != null) {
                                  int varientPercent;
                                  var amount = data?.first.price.toInt();

                                  if (newValue == "Intermediate") {
                                    varientPercent = provider.courseDetailModel
                                            ?.variant?.first.amountPerc
                                            ?.toInt() ??
                                        0;
                                  } else if (newValue == "Beginner") {
                                    varientPercent = provider.courseDetailModel
                                            ?.variant?[1].amountPerc
                                            ?.toInt() ??
                                        0;
                                  } else {
                                    varientPercent = provider.courseDetailModel
                                            ?.variant?[2].amountPerc
                                            ?.toInt() ??
                                        0;
                                  }

                                  var disAmount =
                                      ((varientPercent / 100) * amount).toInt();
                                  TotalAmount = TotalAmount - disAmount;
                                  log("Variant Percent: $varientPercent");
                                  log("Discount Amount: $disAmount");
                                  log("Total Amount: $TotalAmount");
                                  log("Total Amount2: ${provider.courseDetailModel?.variant?[2].amountPerc}");
                                  log("Total Amount1: ${provider.courseDetailModel?.variant?[1].amountPerc}");
                                  log("Total Amount0: ${provider.courseDetailModel?.variant?[0].amountPerc}");

                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                  log("selected value---$selectedValue");
                                }
                              },
                              items: varient.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(location),
                                  ),
                                );
                              }).toList(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: ColorConstants.button_color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data?.first.description ?? "",
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        StarRating(rating: data?.first.ratingCount ?? 0),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Bestseller",
                        style: TextStyle(color: ColorConstants.primary_white),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          TotalAmount == 0
                              ? "₹ " + "${data?.first.price.toInt()}"
                              : "₹ " + "${TotalAmount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TotalAmount == 0
                            ? SizedBox()
                            : Text(
                                "₹ " + "${data?.first.price.toInt() ?? ""}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: ColorConstants.primary_black
                                      .withOpacity(.4),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: ColorConstants.primary_black
                                      .withOpacity(.4),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Author-  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          data?.first.instructor?.name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ColorConstants.button_color),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            var courseID = data?.first.id;
                            var variantID = 1;
                            var price = data?.first.price.toInt();
                            await context
                                .read<Wishlistcontroller>()
                                .AddWishlist(courseID, price, variantID);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: ColorConstants.button_color,
                                content: Text("Added sucessfully"),
                              ),
                            );
                          },
                          child: Container(
                            height: 53,
                            width: 152,
                            decoration: BoxDecoration(
                                color: ColorConstants.button_color,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: ColorConstants.primary_white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " Add wishlist",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: ColorConstants.button_color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var courseID = data?.first.id;
                            var variantID;
                            if (selectedValue == "Beginner") {
                              variantID = 1;
                            } else if (selectedValue == "Intermediate") {
                              variantID = 2;
                            } else {
                              variantID = 3;
                            }

                            var price = data?.first.price.toInt();
                            context.read<Cartcontroller>().AddCartItems(
                                courseID,
                                variantID,
                                TotalAmount,
                                context,
                                true);
                          },
                          child: Container(
                            height: 53,
                            width: 152,
                            decoration: BoxDecoration(
                                color: ColorConstants.button_color,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: ColorConstants.primary_white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   Icons.shopping_cart,
                                      //   color: ColorConstants.button_color,
                                      // ),
                                      Text(
                                        " Add to cart",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: ColorConstants.button_color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    getprovider?.length == 0
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recently viewed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // provider.isLoading
                              //     ? Center(child: CircularProgressIndicator())
                              //     : GridView.builder(
                              //         shrinkWrap: true,
                              //         physics: NeverScrollableScrollPhysics(),
                              //         gridDelegate:
                              //             SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisCount: 2, mainAxisSpacing: 10,
                              //           childAspectRatio:
                              //               1, // Adjusts the aspect ratio of each item
                              //           crossAxisSpacing: 5, // Space between columns
                              //         ),
                              //         itemCount: 4,
                              //         itemBuilder: (context, index) {
                              // var id =
                              //     provider.recommendedModel?.data?[index].id;
                              //           return InkWell(
                              //             onTap: () {
                              //               Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         DetailPage(id: id ?? 0),
                              //                   ));
                              //               context
                              //                   .read<HomepageController>()
                              //                   .getCourseDetails(id);
                              //             },
                              //             child: SearchCard(
                              //               index: index,
                              //             ),
                              //           );
                              //         },
                              //       ),
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
                                                        builder: (context) =>
                                                            DetailPage(id: id),
                                                      ));
                                                },
                                                child:
                                                    SearchCard(index: index)),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
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
                                                    caption: "Recently viewed",
                                                    value: "recently",
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            "See all  ",
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.button_color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
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
                    // SizedBox(
                    //   height: 30,
                    // ),
                    Text(
                      "Recommentions",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var id = provider.recommendedModel?.data?[index].id;
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
                        itemCount: 5),
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
