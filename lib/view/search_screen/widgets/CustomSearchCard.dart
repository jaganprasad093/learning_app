import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/widgets/custom_favoriteIcon.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/core/widgets/showdailog.dart';
import 'package:provider/provider.dart';

class CustomSearchCard extends StatefulWidget {
  final int index;
  final String name;
  final String author_name;
  final int rating;
  final int price;
  final int courseID;
  final String photo;

  const CustomSearchCard(
      {super.key,
      required this.index,
      required this.name,
      required this.rating,
      required this.price,
      required this.author_name,
      required this.courseID,
      required this.photo});

  @override
  State<CustomSearchCard> createState() => _CustomSearchCardState();
}

class _CustomSearchCardState extends State<CustomSearchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(),
              height: 100,
              // width: 150,
              child: ClipRRect(
                child: Image.network(
                  widget.photo,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              right: 3,
              top: 3,
              child: FavoriteButton(
                  courseId: widget.courseID, price: widget.price),
            )
          ]),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            widget.author_name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Row(
            children: [
              StarRating(rating: widget.rating),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹ " + "${widget.price}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
