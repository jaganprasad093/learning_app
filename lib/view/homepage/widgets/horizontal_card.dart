import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class HorizontalCard extends StatelessWidget {
  final bool islearning;
  final String photo;
  final String author_name;
  final price;
  final String course_name;
  final String description;
  const HorizontalCard(
      {super.key,
      required this.islearning,
      required this.photo,
      required this.author_name,
      required this.price,
      required this.course_name,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            width: 70,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                softWrap: true,
              ),
              description == ""
                  ? SizedBox()
                  : Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(),
                      softWrap: true,
                    ),
              SizedBox(
                height: 5,
              ),
              Text(
                author_name,
                style: TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
              ),
              SizedBox(
                height: 10,
              ),
              islearning
                  ? Container()
                  : Text(
                      "₹ " + "${price.toInt()}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Bestseller",
                  style: TextStyle(color: ColorConstants.primary_white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
