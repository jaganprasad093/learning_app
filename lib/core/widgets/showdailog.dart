import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class CustomShowdailog {
  void showDialogWithFields(
      BuildContext context, final void Function()? onTap) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                // Container(decoration: BoxDecoration(image:DecorationImage(image: NetworkImage("")) ),)
                Text(
                  "Add this course to cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.shopping_cart_rounded,
                  size: 60,
                )
              ],
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: ColorConstants.button_color,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
