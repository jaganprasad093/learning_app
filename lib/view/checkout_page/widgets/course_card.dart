import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                height: 70,
                width: 70,
                child: Image.network(
                  "https://images.pexels.com/photos/19641063/pexels-photo-19641063/free-photo-of-silhouette-of-couple-on-a-hill.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We recommend verifying at least one more ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      softWrap: true,
                    ),
                    Text(
                      "least one more email",
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
                      "₹399 ",
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
                Text(
                  "₹399 ",
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
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: 70,
              // ),
              Text(
                "Remove",
                style: TextStyle(color: ColorConstants.button_color),
              ),
              Text(
                "Save for Later",
                style: TextStyle(color: ColorConstants.button_color),
              ),
              Text(
                "Move to Wishlist",
                style: TextStyle(color: ColorConstants.button_color),
              ),
            ],
          ),
        )
      ],
    );
  }
}
