import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 150,
            color: ColorConstants.button_color,
            child: Image.network(
              "https://images.pexels.com/photos/27852643/pexels-photo-27852643/free-photo-of-landmark-81.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "te tailored  paths... ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text("athors name")
        ],
      ),
    );
  }
}
