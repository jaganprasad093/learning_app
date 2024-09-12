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

class RecommentionsCard extends StatefulWidget {
  final int index;

  const RecommentionsCard({super.key, required this.index});

  @override
  State<RecommentionsCard> createState() => _RecommentionsCardState();
}

class _RecommentionsCardState extends State<RecommentionsCard> {
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
    var data = context
        .watch<HomepageController>()
        .recommendedModel
        ?.data?[widget.index];
    var provider = context
        .watch<HomepageController>()
        .recommendedModel
        ?.data?[widget.index];
    return Row(
      children: [
        Stack(children: [
          Container(
            height: 100,
            width: 150,
            child: Image.network(
              data?.thumbnail?.fullSize ?? "",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: InkWell(
              onTap: () {
                var course = provider?.id;
                var price = provider?.price?.toInt();
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
                isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
                color: isFavorite ? Colors.red : ColorConstants.primary_white,
              ),
            ),
          )
        ]),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.courseName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                data?.description ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                data?.instructor?.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  StarRating(rating: data?.rating ?? 0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹" + "${data?.price ?? 0}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  InkWell(
                      onTap: () {
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
        ),
      ],
    );
  }
}
