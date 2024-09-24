import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ConfrimAnimated extends StatelessWidget {
  const ConfrimAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Cartcontroller>();
    return Scaffold(
      backgroundColor: ColorConstants.primary_white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/animated.json",
                fit: BoxFit.cover, reverse: false, repeat: false),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
            ),
            Text("Your order Id: ${provider.orderId}"),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              text: "Go to my learning",
              onTap: () {
                Navigator.pushReplacementNamed(context, "/mylearning");
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/bottomnavigation");
                },
                text: "Back to home")
          ],
        ),
      ),
    );
  }
}
