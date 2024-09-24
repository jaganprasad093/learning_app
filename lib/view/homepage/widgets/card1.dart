import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_favoriteIcon.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/core/widgets/showdailog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Card1 extends StatefulWidget {
  final int index;
  const Card1({super.key, required this.index});

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
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
    var provider = context
        .watch<HomepageController>()
        .recommendedModel
        ?.data?[widget.index];

    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 120,
              width: 200,
              color: ColorConstants.button_color,
              child: Image.network(
                provider?.thumbnail?.fullSize ?? "",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              right: 3,
              top: 3,
              child: FavoriteButton(
                  courseId: provider?.id, price: provider?.price?.toInt()),
              // child: InkWell(
              //   onTap: () {
              //     var course = provider?.id;
              //     var price = provider?.price?.toInt();
              //     var variant = 1;
              //     setState(() {
              //       isFavorite = !isFavorite;
              //       if (isFavorite) {
              //         context
              //             .read<Wishlistcontroller>()
              //             .AddWishlist(course, price, variant);
              //         ids?.add(course.toString());
              //       } else {
              //         context
              //             .read<Wishlistcontroller>()
              //             .removeWishlist(course, variant, false, context);
              //         ids?.remove(course.toString());
              //       }
              //     });
              //   },
              //   child: Icon(
              //     isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
              //     color: isFavorite ? Colors.red : ColorConstants.primary_white,
              //   ),
              // ),
            )
          ]),
          Text(
            provider?.courseName ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider?.instructor?.name ?? ""),
                  StarRating(rating: provider?.ratingCount ?? 0),
                  Text(
                    "₹" + "${provider?.price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
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
                        context.read<Cartcontroller>().getCart();
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
