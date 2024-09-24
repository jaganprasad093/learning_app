import 'package:flutter/material.dart';
import 'package:learning_app/core/widgets/custom_star.dart';

class CategoryCard extends StatelessWidget {
  final String course_name;
  final String photo;
  final int rating;
  final double price;

  const CategoryCard(
      {super.key,
      required this.course_name,
      required this.rating,
      required this.price,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
                // color: ColorConstants.green,
                image: DecorationImage(image: NetworkImage(photo))),
          ),
          Text(
            course_name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          StarRating(rating: rating),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "₹ " + "${price.toInt()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Text(
                  //   "₹ " + "${price}",
                  //   style: TextStyle(
                  //     decoration: TextDecoration.lineThrough,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                width: 200,
              ),
              Icon(Icons.shopping_bag_sharp)
            ],
          ),
        ],
      ),
    );
  }
}
