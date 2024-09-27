import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/model/courseDetail_model.dart';
import 'package:learning_app/view/detail_page/widgets/custom_slide.dart';
import 'package:learning_app/view/detail_page/widgets/recent_seeall.dart';
import 'package:learning_app/view/detail_page/widgets/review_screen.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/homepage/widgets/recentlyViewed.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String? navigation;

  const DetailPage({
    super.key,
    required this.id,
    this.navigation,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<CourseDetailModel?> _futureBuilder;
  @override
  void initState() {
    context.read<HomepageController>().getRecentlyViewed();
    _futureBuilder =
        context.read<HomepageController>().getCourseDetails(widget.id);
    context.read<Wishlistcontroller>().getWishlist();
    ini();
    super.initState();
  }

  List varient = [
    'Beginner',
    'Intermediate',
    'Expert',
  ];
  String selectedValue = "Beginner";
  int TotalAmount = 0;
  List<String>? ids;
  List navList = [];
  bool isRead = false;
  void onTapLink() {
    setState(() => isRead = !isRead);
  }

  ini() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ids = prefs.getStringList("courseID") ?? [];
    log("course id in detail page ${ids}");
    log("navigation screen--${widget.navigation}");
    navList.add(widget.navigation.toString());
    log("list nav-----$navList");
    // if (widget.navigation != "detail") {
    // } else {}
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomepageController>();
    // var datas = provider.courseDetailModel?.data;
    var getprovider = provider.recentlyViewedModel?.data?.data;
    var cartProvider = context.watch<Cartcontroller>();
    var wishlistProvider = context.watch<Wishlistcontroller>();
    bool isFavorite =
        wishlistProvider.favoriteIds.contains(widget.id.toString());
    // log("isfavorite---$isFavorite");
    // log("list from wishlist---${wishlistProvider.favoriteIds}");
    // log("id passed by detail page---${widget.id}");
    // bool isCart=cartProvider.cartModel.data.cartItem.contains()
    // log("data-----$data");
    bool isCart = cartProvider.cartItems.contains(widget.id);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/checkout");
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 26,
                  ),
                  cartProvider.cartModel?.data?.cartItem?.length == 0 ||
                          cartProvider.cartModel?.data?.cartItem?.length == null
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
                                    color: ColorConstants.primary_white),
                              ),
                            ),
                            radius: 7,
                            backgroundColor: Colors.red,
                          ))
                ],
              )),
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

                // calling future builder

                child: FutureBuilder<CourseDetailModel?>(
                    future: _futureBuilder,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData ||
                          snapshot.hasError ||
                          snapshot.data == null) {
                        return Text('No Data Found');
                      }
                      CourseDetailModel? item = snapshot.data;
                      List<Datum> dataum = item?.data ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              // color: ColorConstants.button_color,
                              // child: Image.network(
                              //   dataum.first.thumbnail?.fullSize ?? "",
                              //   fit: BoxFit.cover,
                              // ),
                              child: CustomSlideImage(
                                  imageUrls:
                                      dataum.first.thumbnail?.fullSize ?? "",
                                  videoUrl: dataum.first.introVideo ?? ""),
                              height: 220,
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
                                dataum.first.courseName ?? "",
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
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 10),
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
                                      var grandTotal =
                                          dataum.first.price.toInt();

                                      if (newValue != null) {
                                        int varientPercent;
                                        var amount = dataum.first.price.toInt();

                                        if (newValue == "Intermediate") {
                                          varientPercent = provider
                                                  .courseDetailModel
                                                  ?.variant
                                                  ?.first
                                                  .amountPerc
                                                  ?.toInt() ??
                                              0;
                                        } else if (newValue == "Beginner") {
                                          varientPercent = provider
                                                  .courseDetailModel
                                                  ?.variant?[1]
                                                  .amountPerc
                                                  ?.toInt() ??
                                              0;
                                        } else {
                                          varientPercent = provider
                                                  .courseDetailModel
                                                  ?.variant?[2]
                                                  .amountPerc
                                                  ?.toInt() ??
                                              0;
                                        }

                                        var disAmount =
                                            ((varientPercent / 100) * amount)
                                                .toInt();
                                        TotalAmount = grandTotal - disAmount;
                                        log("Variant Percent: $varientPercent");
                                        log("Discount Amount: $disAmount");
                                        log("Total Amount: $TotalAmount");
                                        log("Total Amount2: ${provider.courseDetailModel?.variant?[2].amountPerc}");
                                        log("Total Amount1: ${provider.courseDetailModel?.variant?[1].amountPerc}");
                                        log("Total Amount0: ${provider.courseDetailModel?.variant?[0].amountPerc}");

                                        setState(() {
                                          selectedValue = newValue;
                                          TotalAmount;
                                        });
                                        log("selected value---$selectedValue");
                                      }
                                    },
                                    items: varient.map((location) {
                                      return DropdownMenuItem<String>(
                                        value: location,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
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
                          // Text(
                          //   dataum.first.description ?? "",
                          //   // overflow: TextOverflow.ellipsis,
                          //   // maxLines: 2,
                          //   style: TextStyle(fontWeight: FontWeight.normal),
                          // ),
                          ReadMoreText(
                            dataum.first.description ?? "",
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            lessStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.button_color),
                            trimCollapsedText: 'See more',
                            trimExpandedText: ' Show less',
                            moreStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.button_color),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewScreen(
                                            courseID: widget.id,
                                            rating: dataum.first.rating,
                                            ratingCount: dataum.first.rating,
                                            // totalReviees: dataum.first.,
                                          ),
                                        ));
                                  },
                                  child: StarRating(
                                      rating: dataum.first.ratingCount ?? 0)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Bestseller",
                              style: TextStyle(
                                  color: ColorConstants.primary_white),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                TotalAmount == 0
                                    ? "₹ " + "${dataum.first.price.toInt()}"
                                    : "₹ " + "${TotalAmount}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TotalAmount == 0
                                  ? SizedBox()
                                  : TotalAmount == dataum.first.price.toInt()
                                      ? SizedBox()
                                      : Text(
                                          "₹ " +
                                              "${dataum.first.price.toInt() ?? ""}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            color: ColorConstants.primary_black
                                                .withOpacity(.4),
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: ColorConstants
                                                .primary_black
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
                                dataum.first.instructor?.name ?? "",
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
                                  var courseID = dataum.first.id;
                                  var variantID = 1;
                                  var price = dataum.first.price.toInt();

                                  if (isFavorite) {
                                    Navigator.pushNamed(context, "/wishlist");
                                  } else {
                                    await context
                                        .read<Wishlistcontroller>()
                                        .AddWishlist(
                                            courseID, price, variantID);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            ColorConstants.button_color,
                                        content: Text("Added sucessfully"),
                                      ),
                                    );
                                  }
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            isFavorite
                                                ? Text(
                                                    "View wishlist",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: ColorConstants
                                                            .button_color),
                                                  )
                                                : Text(
                                                    " Add wishlist",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: ColorConstants
                                                            .button_color),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (isCart) {
                                    Navigator.pushNamed(context, "/checkout");
                                  } else {
                                    var courseID = dataum.first.id;
                                    var variantID;
                                    if (selectedValue == "Beginner") {
                                      variantID = 1;
                                    } else if (selectedValue ==
                                        "Intermediate") {
                                      variantID = 2;
                                    } else {
                                      variantID = 3;
                                    }

                                    var price = dataum.first.price.toInt();
                                    log("total amount while adding---$TotalAmount");
                                    if (TotalAmount == 0) {
                                      TotalAmount = price;

                                      cartProvider.AddCartItems(
                                          courseID,
                                          variantID,
                                          TotalAmount,
                                          context,
                                          true);
                                      setState(() {
                                        TotalAmount = 0;
                                      });
                                    } else {
                                      cartProvider.AddCartItems(
                                          courseID,
                                          variantID,
                                          TotalAmount,
                                          context,
                                          true);
                                      setState(() {
                                        TotalAmount = 0;
                                      });
                                    }
                                    await context
                                        .read<Cartcontroller>()
                                        .getCart();
                                  }
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Icon(
                                            //   Icons.shopping_cart,
                                            //   color: ColorConstants.button_color,
                                            // ),
                                            cartProvider.isLoading
                                                ? CircularProgressIndicator()
                                                : isCart
                                                    ? Text(
                                                        " View cart",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: ColorConstants
                                                                .button_color),
                                                      )
                                                    : Text(
                                                        "Add to cart",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: ColorConstants
                                                                .button_color),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
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
                                                      ? (getprovider?.length ??
                                                          0)
                                                      : 3,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          (getprovider != null &&
                                                  getprovider.length > 3)
                                              ? Column(
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
                                                                value:
                                                                    "recently",
                                                              ),
                                                            ));
                                                      },
                                                      child: Text(
                                                        "See all  ",
                                                        style: TextStyle(
                                                            color: ColorConstants
                                                                .button_color,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 90,
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
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
                              itemCount: 5),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
              ),
            ),
    );
  }
}
