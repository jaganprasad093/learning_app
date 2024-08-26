// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:learning_app/core/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  Function()? onTap;
  CustomButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            // width: 200,
            decoration: BoxDecoration(
              color: ColorConstants.button_color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
