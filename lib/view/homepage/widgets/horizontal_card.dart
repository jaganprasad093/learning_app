import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class HorizontalCard extends StatelessWidget {
  final bool islearning;
  const HorizontalCard({super.key, required this.islearning});

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                softWrap: true,
              ),
              Text(
                "least one more email",
                style: TextStyle(),
                softWrap: true,
              ),
              islearning
                  ? Container()
                  : Text(
                      "₹ 674.00",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      softWrap: true,
                    )
            ],
          ),
        )
      ],
    );
  }
}
