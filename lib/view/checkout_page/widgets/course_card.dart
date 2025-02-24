import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final String course_name;
  final String auther_name;
  final String price;
  final String TotalAmount;
  final String photo;

  final String courseID;
  final String variantID;
  const CourseCard(
      {super.key,
      required this.course_name,
      required this.auther_name,
      required this.price,
      required this.photo,
      required this.courseID,
      required this.variantID,
      required this.TotalAmount});

  @override
  Widget build(BuildContext context) {
    log("price-----$price");
    log("total price-----$TotalAmount");
    return Column(
      children: [
        Container(
          height: .5,
          color: ColorConstants.primary_black.withOpacity(.5),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(
                  photo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course_name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      softWrap: true,
                    ),
                    Text(
                      auther_name,
                      style: TextStyle(),
                      softWrap: true,
                    ),
                  ]),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color),
                    ),
                    Icon(
                      Icons.sell,
                      color: ColorConstants.button_color,
                    ),
                  ],
                ),
                TotalAmount == price
                    ? SizedBox()
                    : Text(
                        "₹ " + "${TotalAmount}",
                        style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: ColorConstants.primary_black.withOpacity(.7),
                            decoration: TextDecoration.lineThrough),
                      ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: 70,
              // ),
              InkWell(
                onTap: () {
                  CustomDialog().showDialogWithFields(context, () {
                    context
                        .read<Cartcontroller>()
                        .removeCartItems(courseID, variantID);
                    Navigator.pop(context);
                  }, "Are you sure remove the $course_name from cart?", "Yes");
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Remove",
                    style: TextStyle(color: ColorConstants.button_color),
                  ),
                ),
              ),
              // Text(
              //   "Save for Later",
              //   style: TextStyle(color: ColorConstants.button_color),
              // ),
              InkWell(
                onTap: () {
                  context
                      .read<Wishlistcontroller>()
                      .AddWishlist(courseID, price, variantID);
                  // CustomSnackbar(
                  //   message: "Added sucessfully",
                  //   backgroundColor: Colors.green,
                  // );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                      content: Text("Item added wishlist sucessfully"),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Move to Wishlist",
                    style: TextStyle(color: ColorConstants.button_color),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
