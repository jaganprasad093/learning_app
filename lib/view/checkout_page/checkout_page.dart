import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/checkout_page/widgets/course_card.dart';
import 'package:learning_app/view/checkout_page/widgets/checkout_bottomnavigation.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    // context.read<Cartcontroller>().removeCartItems(5, 1);
    context.read<Cartcontroller>().getCart();
    // context.read<Cartcontroller>().AddCartItems(17, 8000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Cartcontroller>();
    log("lenth of cart---${provider.cartModel?.data?.cartItem?.length}");
    int TotalAmount;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart Items",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: provider.cartModel?.data?.cartItem?.length == null ||
                provider.cartModel?.data?.cartItem?.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Your cart is empty !")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              ColorConstants.button_color)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigation(initialIndex: 0),
                            ));
                      },
                      child: Text(
                        "Back to homescreen",
                        style: TextStyle(
                            color: ColorConstants.primary_white,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            : Consumer<Cartcontroller>(
                builder: (context, value, child) => provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Total: ",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "₹ " +
                                        "${provider.cartModel?.data?.grandTotal.toInt()} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // TextSpan(
                                  //   text: "₹ 1999",
                                  //   style: TextStyle(
                                  //     color: Colors.black.withOpacity(.4),
                                  //     decoration: TextDecoration.lineThrough,
                                  //   ),
                                  // ),
                                  // TextSpan(
                                  //   text: "  73% off",
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "${provider.cartModel?.data?.cartItem?.length}" +
                                  " Course in Cart",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: provider.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        var data = value
                                            .cartModel?.data?.cartItem?[index];
                                        var auther_name = data?.autherName;
                                        var course_name = data?.courseName;
                                        var photo = data?.courseImage;

                                        var courseId =
                                            data?.courseId.toString();
                                        var variantID =
                                            data?.section?.id.toString();
                                        var selectedVarient =
                                            data?.section?.name;
                                        var price = data?.price.toInt();

                                        int variantPercent;
                                        variantPercent = data
                                                ?.section?.amountPerc
                                                ?.toInt() ??
                                            0;
                                        // var disAmount =
                                        //     ((variantPercent / 100) * price)
                                        //         .toInt();
                                        // TotalAmount = price + disAmount;

                                        calculateOriginalPrice(
                                            currentPrice, discountPercentage) {
                                          var discountFactor =
                                              1 - (discountPercentage / 100);
                                          return currentPrice / discountFactor;
                                        }

                                        ;

                                        TotalAmount = calculateOriginalPrice(
                                                price, variantPercent)
                                            .toInt();

                                        log(" total amount---$TotalAmount");
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          id: data?.courseId ??
                                                              0),
                                                ));
                                            log("course id in detailpage--${data?.courseId ?? 0}");
                                          },
                                          child: CourseCard(
                                            TotalAmount: TotalAmount.toString(),
                                            auther_name: auther_name ?? "",
                                            course_name: course_name ?? "",
                                            photo: photo ?? "",
                                            price: price.toString(),
                                            courseID: courseId ?? "",
                                            variantID: variantID ?? "",
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 20,
                                          ),
                                      itemCount: value.cartModel?.data?.cartItem
                                              ?.length ??
                                          0),
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              text: "Complete Checkout",
                              onTap: () {
                                checkout().showBottomsheet(
                                    context,
                                    provider.cartModel?.data?.grandTotal
                                        .toInt());
                              },
                            ),
                          ],
                        ),
                      ),
              ));
  }
}
