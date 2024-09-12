// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/wishlist_controller/WishlistController.dart';
import 'package:learning_app/core/widgets/showdailog.dart';
import 'package:provider/provider.dart';

import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Card3 extends StatefulWidget {
  final int index;
  Card3({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var provider = context
        .watch<HomepageController>()
        .featuredCoursesModel
        ?.data?[widget.index];
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 100,
              width: 150,
              color: ColorConstants.button_color,
              child: Image.network(
                provider?.thumbnail?.fullSize ?? "",
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
                  var varient = 1;
                  setState(() {
                    isFavorite = !isFavorite;
                    if (isFavorite) {
                      context
                          .read<Wishlistcontroller>()
                          .AddWishlist(course, price, varient);
                    } else {
                      context
                          .read<Wishlistcontroller>()
                          .removeWishlist(course, varient);
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
          Text(
            provider?.courseName ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            provider?.instructor?.name ?? "",
            // maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹" + "${provider?.price}",
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
    );
  }
}
