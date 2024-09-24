import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_dialog.dart';
import 'package:learning_app/core/widgets/custom_favoriteIcon.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/core/widgets/showdailog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HorizontalCard extends StatefulWidget {
  final bool islearning;
  final String photo;
  final String author_name;
  final price;
  final String course_name;
  final String description;
  final int index;
  final bool isWishlist;
  final int courseID;
  final int rating;
  final bool? iscart;
  const HorizontalCard(
      {super.key,
      required this.islearning,
      required this.photo,
      required this.author_name,
      required this.price,
      required this.course_name,
      required this.description,
      required this.index,
      required this.isWishlist,
      required this.courseID,
      required this.rating,
      this.iscart});

  @override
  State<HorizontalCard> createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  bool isFavorite = false;
  List<String>? ids;

  @override
  void initState() {
    super.initState();
    // context.read<HomepageController>().getRecommendedCourses();
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
        .read<HomepageController>()
        .recommendedModel
        ?.data?[widget.index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                widget.photo,
                fit: BoxFit.fill,
              ),
            ),
            widget.iscart == true
                ? SizedBox()
                : widget.isWishlist
                    ? SizedBox()
                    : Positioned(
                        right: 3,
                        top: 3,
                        child: FavoriteButton(
                            courseId: provider?.id,
                            price: provider?.price?.toInt()),
                        // child: InkWell(
                        //   onTap: () {
                        //     // var provider = context
                        //     //     .watch<HomepageController>()
                        //     //     .recommendedModel
                        //     //     ?.data?[widget.index];
                        //     // var course = provider?.id;
                        //     // var price = provider?.price?.toInt();
                        //     var variant = 1;
                        //     setState(() {
                        //       isFavorite = !isFavorite;
                        //       if (isFavorite) {
                        //         context.read<Wishlistcontroller>().AddWishlist(
                        //             widget.courseID, widget.price, variant);
                        //         ids?.add(widget.courseID.toString());
                        //       } else {
                        //         context.read<Wishlistcontroller>().removeWishlist(
                        //             widget.courseID, variant, false, context);
                        //         ids?.remove(widget.courseID.toString());
                        //       }
                        //     });
                        //   },
                        //   child: Icon(
                        //     isFavorite
                        //         ? Icons.favorite
                        //         : Icons.favorite_border_sharp,
                        //     color: isFavorite
                        //         ? Colors.red
                        //         : ColorConstants.primary_white,
                        //   ),
                        // ),
                      )
          ]),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.course_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                softWrap: true,
              ),
              widget.description == ""
                  ? SizedBox()
                  : Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(),
                      softWrap: true,
                    ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Author name- ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary_black.withOpacity(.4)),
                    softWrap: true,
                  ),
                  Expanded(
                    child: Text(
                      widget.author_name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  StarRating(rating: widget.rating),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.islearning
                      ? Container()
                      : Text(
                          "₹ " + "${widget.price.toInt()}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                  SizedBox(
                    width: 160,
                  ),
                  widget.iscart == true
                      ? SizedBox()
                      : InkWell(
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
                                await context
                                    .read<Cartcontroller>()
                                    .AddCartItems(courseID, variantID, price,
                                        context, false);
                                context.read<Cartcontroller>().getCart();
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.local_mall),
                          )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.iscart == true
                      ? SizedBox()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Bestseller",
                            style:
                                TextStyle(color: ColorConstants.primary_white),
                          ),
                        ),
                  SizedBox(
                    width: 115,
                  ),
                  widget.isWishlist
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              CustomDialog().showDialogWithFields(context, () {
                                context
                                    .read<Wishlistcontroller>()
                                    .removeWishlist(
                                        widget.courseID, 1, false, context);
                                Navigator.pop(context);
                                ids?.remove(widget.courseID.toString());
                              }, "Are you sure to remove ${widget.course_name} from wishlist",
                                  "Submit");
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Remove",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.button_color),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 8,
                        ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
