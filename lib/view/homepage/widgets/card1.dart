import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 200,
            color: ColorConstants.button_color,
            child: Image.network(
              "https://images.pexels.com/photos/27791671/pexels-photo-27791671/free-photo-of-evening-street.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "te tailored learning paths.... ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text("athors name")
        ],
      ),
    );
  }
}
