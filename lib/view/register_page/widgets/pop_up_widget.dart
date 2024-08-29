import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class SuccessDialog extends StatelessWidget {
  // final String message;
  // final String buttonText;
  final VoidCallback onButtonPressed;

  const SuccessDialog({
    Key? key,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              "Success!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Your account have been created successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: InkWell(
            onTap: onButtonPressed,
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: ColorConstants.button_color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
