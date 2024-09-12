import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/core/widgets/showdailog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCard extends StatefulWidget {
  final int index;
  const SearchCard({super.key, required this.index});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool isFavorite = false;
  List<String>? ids;

  @override
  void initState() {
    super.initState();
    ini();
  }

  ini() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ids = prefs.getStringList("courseID") ?? [];

    var provider1 = context
        .read<HomepageController>()
        .recommendedModel
        ?.data?[widget.index]
        .id;

    if (provider1 != null && ids!.contains(provider1.toString())) {
      setState(() {
        isFavorite = true;
      });
      log("id---$provider1");
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider2 = context
        .watch<HomepageController>()
        .recommendedModel
        ?.data?[widget.index];
    var provider = context.read<HomepageController>();
    var data = provider.recentlyViewedModel?.data?.data?[widget.index];
    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: ColorConstants.primary_white,
          ))
        : Container(
            height: 200,
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(),
                    height: 100,
                    width: 150,
                    child: ClipRRect(
                      child: Image.network(
                        data?.courseThumbnail ?? "",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: 3,
                    child: InkWell(
                      onTap: () {
                        var course = provider2?.id;
                        var price = provider2?.price?.toInt();
                        var variant = 1;
                        setState(() {
                          isFavorite = !isFavorite;
                          if (isFavorite) {
                            context
                                .read<Wishlistcontroller>()
                                .AddWishlist(course, price, variant);
                            ids?.add(course.toString());
                          } else {
                            context
                                .read<Wishlistcontroller>()
                                .removeWishlist(course, variant);
                            ids?.remove(course.toString());
                          }
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_sharp,
                        color: isFavorite
                            ? Colors.red
                            : ColorConstants.primary_white,
                      ),
                    ),
                  )
                ]),
                Text(
                  data?.courseName ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  data?.instructorName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Row(
                  children: [
                    StarRating(rating: data?.ratingCount ?? 0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ " + "${data?.coursePrice.toInt()}",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    InkWell(
                        onTap: () {
                          var provider = context
                              .read<HomepageController>()
                              .recommendedModel
                              ?.data?[widget.index];
                          var courseID = provider?.id;
                          var variantID = 1;
                          var price = provider?.price;
                          CustomShowdailog().showDialogWithFields(
                            context,
                            () async {
                              await context.read<Cartcontroller>().AddCartItems(
                                  courseID, variantID, price, context, false);
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Icon(Icons.local_mall)),
                  ],
                ),
              ],
            ),
          );
  }
}
